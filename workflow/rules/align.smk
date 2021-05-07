#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
@author: YangyangLi
@contact:li002252@umn.edu
@version: 0.0.1
@license: MIT Licence
@file: align.smk
@time: 2021/4/23 9:07 PM
"""

from snakemake.utils import validate
import pandas as pd

# this container defines the underlying OS for each job when using the workflow
# with --use-conda --use-singularity
singularity: "docker://continuumio/miniconda3"

##### load config and sample sheets #####

configfile: "config/config.yaml"
validate(config, schema="../schemas/config.schema.yaml")

WORKING_DIR = config['wkdir']
RESULT_DIR  = config['resultdir']

samples = pd.read_csv(config["samples"], sep="\t").set_index("samples", drop=False)

samples.index.names = ["sample_id"]

validate(samples, schema="../schemas/samples.schema.yaml")


def get_fastq(wildcards):
    """ This function checks if the sample has paired end or single end reads
    and returns 1 or 2 names of the fastq files """

    return samples.loc[(wildcards.sample), ["fq1", "fq2"]].dropna()

rule fastp:
    input:
        get_fastq
    output:
        fq1  = WORKING_DIR + "trimmed/" + "{sample}_R1_trimmed.fq.gz",
        fq2  = WORKING_DIR + "trimmed/" + "{sample}_R2_trimmed.fq.gz",
        html = RESULT_DIR + "fastp/{sample}.html"
    message:"trimming {wildcards.sample} reads"
    threads: 10
    log:
        RESULT_DIR + "fastp/{sample}.log.txt"
    params:
        sampleName = "{sample}",
        qualified_quality_phred = config["fastp"]["qualified_quality_phred"]

    shell:
        "fastp --thread {threads}  --html {output.html} \
            --qualified_quality_phred {params.qualified_quality_phred} \
            --detect_adapter_for_pe \
            --in1 {input[0]} --in2 {input[1]} --out1 {output.fq1} --out2 {output.fq2}; \
            2> {log}"


#########################
# RNA-Seq read alignement
#########################

rule index:
    input:
        WORKING_DIR + "genome/genome.fasta"
    output:
        [WORKING_DIR + "genome/genome." + str(i) + ".ht2" for i in range(1,9)]
    message:
        "indexing genome"
    params:
        WORKING_DIR + "genome/genome"
    threads: 10
    shell:
        "hisat2-build -p {threads} {input} {params} --quiet"

rule hisat_mapping:
    input:
        get_trimmed,
        indexFiles = [WORKING_DIR + "genome/genome." + str(i) + ".ht2" for i in range(1,9)]
    output:
        bams  = WORKING_DIR + "mapped/{sample}.bam",
        sum   = RESULT_DIR + "logs/{sample}_sum.txt",
        met   = RESULT_DIR + "logs/{sample}_met.txt"
    params:
        indexName = WORKING_DIR + "genome/genome",
        sampleName = "{sample}"
    # conda:
    #     "envs/hisat_mapping.yaml"
    message:
        "mapping reads to genome to bam files."
    threads: 10
    run:
        if sample_is_single_end(params.sampleName):
            shell("hisat2 -p {threads} --summary-file {output.sum} --met-file {output.met} -x {params.indexName} \
            -U {input} | samtools view -Sb -F 4 -o {output.bams}")
        else:
            shell("hisat2 -p {threads} --summary-file {output.sum} --met-file {output.met} -x {params.indexName} \
            -1 {input[0]} -2 {input[1]} | samtools view -Sb -F 4 -o {output.bams}")





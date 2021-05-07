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


WORKING_DIR = config["wkdir"]
RESULT_DIR = config["resultdir"]


rule fastp:
    input:
        get_fastq,
    output:
        fq1=WORKING_DIR + "trimmed/" + "{sample}_R1_trimmed.fq.gz",
        fq2=WORKING_DIR + "trimmed/" + "{sample}_R2_trimmed.fq.gz",
        html=RESULT_DIR + "fastp/{sample}.html",
    message:
        "trimming {wildcards.sample} reads"
    threads: 4
    log:
        RESULT_DIR + "fastp/{sample}.log.txt",
    params:
        sampleName="{sample}",
        qualified_quality_phred=config["fastp"]["qualified_quality_phred"],
    shell:
        "fastp --thread {threads}  --html {output.html} \
                                    --qualified_quality_phred {params.qualified_quality_phred} \
                                    --detect_adapter_for_pe \
                                    --in1 {input[0]} --in2 {input[1]} --out1 {output.fq1} --out2 {output.fq2}; \
                                    2> {log}"


rule index:
    input:
        WORKING_DIR + "genome/genome.fasta",
    output:
        [WORKING_DIR + "genome/genome." + str(i) + ".ht2" for i in range(1, 9)],
    message:
        "indexing genome"
    params:
        WORKING_DIR + "genome/genome",
    threads: 4
    shell:
        "hisat2-build -p {threads} {input} {params} --quiet"


rule hisat_mapping:
    input:
        get_trimmed,
        indexFiles=[
            WORKING_DIR + "genome/genome." + str(i) + ".ht2" for i in range(1, 9)
        ],
    output:
        bams=WORKING_DIR + "mapped/{sample}.bam",
        sum=RESULT_DIR + "logs/{sample}_sum.txt",
        met=RESULT_DIR + "logs/{sample}_met.txt",
    params:
        indexName=WORKING_DIR + "genome/genome",
        sampleName="{sample}",
    message:
        "mapping reads to genome to bam files."
    threads: 10
    shell:
        "hisat2 -p {threads} --summary-file {output.sum} --met-file {output.met} -x {params.indexName} \
                                    -1 {input[0]} -2 {input[1]} | samtools view -Sb -F 4 -o {output.bams}"

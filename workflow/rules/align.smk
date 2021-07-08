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



rule mapping:
    input:
        get_fastq,
        # WORKING_DIR + "trimmed/" + "{sample}_R1_trimmed.fq.gz",
        # WORKING_DIR + "trimmed/" + "{sample}_R2_trimmed.fq.gz",
    output:
        sam=WORKING_DIR + "mapped/{sample}.sam",
        sum=RESULT_DIR + "logs/{sample}_sum.txt",
        met=RESULT_DIR + "logs/{sample}_met.txt"
    params:
        indexName=WORKING_DIR + "genome/genome_snp_tran",
        sampleName="{sample}",
    message:
        "mapping reads to genome "
    threads: 10
    shell:
        "hisat2 -p {threads} --summary-file {output.sum} --met-file {output.met} -x {params.indexName} \
                                    -1 {input[0]} -2 {input[1]} -S {output.sam}"

rule sam2bam:
    input:
        WORKING_DIR + "mapped/{sample}.sam"
    output:
        WORKING_DIR + "mapped/{sample}.bam"
    params:
        indexname=WORKING_DIR + "genome/genome_snp_tran.fai"
    message:
        "sam 2 bam with header"
    shell:
        "samtools view -Sh {input} -t {params.indexname} -b -F 4  -o {output}"

rule sortbam:
    input:
        WORKING_DIR + "mapped/{sample}.bam"
    output:
        WORKING_DIR + "mapped/{sample}.sort.bam"
    message:
        "sort bam"
    shell:
        "samtools sort {input} -o {output}"

rule indexbam:
    input:
        WORKING_DIR + "mapped/{sample}.sort.bam"
    output:
        WORKING_DIR + "mapped/{sample}.sort.bam.bai"
    message:
        "index bam"
    shell:
        "samtools index {input} {output}"


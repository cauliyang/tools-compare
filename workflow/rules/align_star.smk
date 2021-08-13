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


rule star_mapping:
    input:
        get_fastq,
    output:
        sam=WORKING_DIR + "mapped/{sample}.sam",
        sum=RESULT_DIR + "logs/{sample}_sum.txt",
        met=RESULT_DIR + "logs/{sample}_met.txt"
    params:
        threads=40,
        indexdir=WORKING_DIR + "genome/",
        sampleName="{sample}",
    message:
        "mapping reads to genome "
    shell:
        "STAR --runThreadN {params.threads} --runMode alignReads \
        --quantMode TranscriptomeSAM GeneCounts \
        --twopassMode Basic \
        --outSAMunmapped None \
        --genomeDir {params.indexdir} \
        --readFilesIn  {input[0]} {input[1]}\
        --outFileNamePrefix {params.sampleName}_"

rule sam2bam:
    input:
        WORKING_DIR + "mapped/{sample}_Aligned.out.sam"
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


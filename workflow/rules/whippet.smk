#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
@author: Yangyangli
@contact: li002252@umn.edu
@version: 0.0.1
@license: MIT Licence
@file: whippet.smk
@time: 25/06/2021 20:06
"""

WORKING_DIR = config["wkdir"]
RESULT_DIR = config["resultdir"]
GTF = config["gtf"]
SCRIPTDIR = config["scriptdir"]

# rule all:
#


rule merge_bam:
    input:
        get_bam
    output:
        WORKING_DIR + "mapped/merge.bam"
    message:
        "Merge bam"
    shell:
        "samtools merge {output} {input}"

rule sort_bam:
    input:
        WORKING_DIR + "mapped/merge.bam"
    output:
        WORKING_DIR + "mapped/merge.sort.bam"
    message:
        "sort merged bam"
    shell:
        "samtools sort -o {output} {input}"

rule rmdup:
    input:
        WORKING_DIR + "mapped/merge.sort.bam"
    output:
        WORKING_DIR + "mapped/merge.sort.rmdup.bam"
    message:
        "rmdup merged bam"
    shell:
        "samtools rmdup -S {input} {output}"

rule index_bam:
    input:
        WORKING_DIR + "mapped/merge.sort.rmdup.bam"
    output:
        WORKING_DIR + "mapped/merge.sort.rmdup.bai"
    message:
        "index merged bam"
    shell:
        "samtools index {input} {output}"

rule whippet:
    input:
        WORKING_DIR + "mapped/merge.sort.rmdup.bam",
        WORKING_DIR + "mapped/merge.sort.rmdup.bai"

    params:
        gtf=GTF,
        genome=WORKING_DIR + "genome/genome_snp_tran.fa",
        script= SCRIPTDIR + "whippet-index.jl"
    message:
        "whippet RUN\n"
    output:
        RESULT_DIR + "whippet"
    shell:
        "julia {params.script} --fasta {params.genome} --bam {input[0]} --gtf {params.gtf}"




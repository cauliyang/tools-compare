#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
@author: Yangyangli
@contact: li002252@umn.edu
@version: 0.0.1
@license: MIT Licence
@file: spladder.smk
@time: 25/06/2021 19:46
"""


WORKING_DIR = config["wkdir"]
RESULT_DIR = config["resultdir"]
GTF = config["gtf"]


# rule all:
#

rule spladder:
    input:
        get_bam
    params:
        gtf=GTF
    message:
        "spladder RUN\n"
    output:
        RESULT_DIR + "spladder"
    shell:
        "spladder build --bams {input}  --annotation  {params.gtf} --outdir {output}"




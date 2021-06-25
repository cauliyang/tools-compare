#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
@author: Yangyangli
@contact: li002252@umn.edu
@version: 0.0.1
@license: MIT Licence
@file: jum.smk
@time: 25/06/2021 21:02
"""


WORKING_DIR = config["wkdir"]
RESULT_DIR = config["resultdir"]
GTF = config["gtf"]


# rule all:
#

rule jum:
    input:

    params:
        tmp=RESULT_DIR + "rmats/tmp_output",
        gtf=GTF,
    message:
        "RMATS RUN\n"
    output:
        RESULT_DIR + OUT
    shell:
        "run_rmats --b1 {input} --gtf {params.gtf}\
          -t paired --readLength 50 --nthread {params.threads} --od {output} --tmp {params.tmp}"


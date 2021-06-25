#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
@author: Yangyangli
@contact: li002252@umn.edu
@version: 0.0.1
@license: MIT Licence
@file: rmats.smk
@time: 11/06/2021 19:38
"""


WORKING_DIR = config["wkdir"]
RESULT_DIR = config["resultdir"]
GTF = config["gtf"]
B1 = config["rmats"]["b1"]
OUT = config["rmats"]["output"]
NTHREADS = config["rmats"]["nthreads"]

rule all:
    pass


rule rmats:
    input:
        B1
    params:
        tmp=RESULT_DIR + "rmats/tmp_output",
        gtf=GTF,
        threads=NTHREADS
    output:
        RESULT_DIR + OUT
    shell:
        "run_rmats --b1 {input} --gtf {params.gtf}\
          -t paired --readLength 50 --nthread {params.threads} --od {output} --tmp {params.tmp}"


#TODO: add scripts to handle result of rmats.


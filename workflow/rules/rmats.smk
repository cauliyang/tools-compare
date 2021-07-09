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
B2 = config["rmats"]["b2"]
OUT = config["rmats"]["output"]
NTHREADS = config["rmats"]["nthreads"]

# rule all:

rule rmats:
    input:
        b1=B1,
        b2=B2,
    params:
        tmp=RESULT_DIR + "rmats/tmp_output",
        gtf=GTF,
        threads=NTHREADS
    message:
        "RMATS RUN\n"
    output:
        RESULT_DIR + OUT
    shell:
        "run_rmats --b1 {input.b1} --b2 {input.b2} --gtf {params.gtf}\
          -t paired --readLength 50 --nthread {params.threads} --od {output} --tmp {params.tmp}"


#TODO: add scripts to handle result of rmats.


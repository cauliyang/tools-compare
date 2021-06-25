#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
@author: Yangyangli
@contact: li002252@umn.edu
@version: 0.0.1
@license: MIT Licence
@file: majiq.smk
@time: 11/06/2021 21:16
"""


WORKING_DIR = config["wkdir"]
RESULT_DIR = config["resultdir"]
GTF = config["gtf"]
LANG = config["majjq"]["lang"]
SCRIPT = config["majiq"]["script"]
CONFIGDIR = config["majiq"]["configdir"]

# rule all:
#

rule majiq:
    input:
        CONFIGDIR + "config.cfg"
    params:
        lang=LANG,
        gtf=GTF,
        script=SCRIPT
    message:
        "MAJIQ RUN\n"
    output:
        RESULT_DIR + "majiq"
    shell:
        "{params.lang} {params.script} {params.gtf} -c {input} -o {output}"


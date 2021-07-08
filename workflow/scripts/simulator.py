#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
@author: Yangyangli
@contact: li002252@umn.edu
@version: 0.0.1
@license: MIT Licence
@file: simulator.py
@time: 04/07/2021 19:52
"""
from pathlib import Path
import pandas as pd

files = "sim_rep_info.txt"  # file path of "sim_rep_info.txt"

PATH = Path(snakemake.input)   # file path of out of simulation

CONFIG_PATH = snakemake.output  # path of config

sample = pd.read_csv(PATH/files, sep='\t')

sample['fq1'] = sample.rep_id.map(lambda x: f'{Path}/{x}_1.fastq')
sample['fq2'] = sample.rep_id.map(lambda x: f'{Path}/{x}_2.fastq')

df = sample.loc[:, ['rep_id', 'fq1', 'fq2', 'group']].rename({'rep_id':'samples'}, axis=1)

df.to_csv(CONFIG_PATH, index=False, sep='\t')



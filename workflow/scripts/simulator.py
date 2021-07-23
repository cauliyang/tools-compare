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
import yaml
import os

def simulator():
    pass


def main(path, config_path):
    files = "sim_rep_info.txt"  # file path of "sim_rep_info.txt"
    path = Path(path)
    # PATH = Path(snakemake.input)  # file path of out of simulation
    #
    # CONFIG_PATH = snakemake.output  # path of config

    sample = pd.read_csv(path / files, sep='\t')
    sample['fq1'] = sample.rep_id.map(lambda x: f'{str(path)}/{x}_1.fastq')
    sample['fq2'] = sample.rep_id.map(lambda x: f'{str(path)}/{x}_2.fastq')
    df = sample.loc[:, ['rep_id', 'fq1', 'fq2', 'group']].rename({'rep_id': 'samples'}, axis=1)
    df.to_csv(config_path, index=False, sep='\t')


if __name__ == "__main__":
    config = yaml.safe_load(open('config/config.yaml'))
    main(config['simulator']['outdir'] + config['simulator']['outname'], "config/samples.tsv")

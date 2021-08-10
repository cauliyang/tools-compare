#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
@author: Yangyangli
@contact: li002252@umn.edu
@version: 0.0.1
@license: MIT Licence
@file: ir_stat.py
@time: 06/08/2021 21:18
"""
import pandas as pd
import sys
from pathlib import Path


def find_genes(dir, file_name="event_annotation.tsv"):
    df = pd.read_table(dir / file_name)
    genes = [gene.split('_')[0] for gene in df['variant'].values]

    return genes


def ir(genes, dir,  file_name='exon_junction_coverage.tsv'):


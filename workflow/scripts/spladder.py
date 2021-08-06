#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
@author: Yangyangli
@contact: li002252@umn.edu
@version: 0.0.1
@license: MIT Licence
@file: spladder.py
@time: 03/08/2021 19:29
"""

import pandas as pd


def main(filename):
    df = pd.read_csv(filename, sep='\t')
    df_a5 = df[df['A5SS'] == False]
    df_a3 = df_a5[df_a5['A3SS'] == False]
    df_only_es = df_a3[df_a3['ES'] == False]
    df_only_es.to_csv('only_es.csv')


if __name__ == '__main__':
    main(filename='')

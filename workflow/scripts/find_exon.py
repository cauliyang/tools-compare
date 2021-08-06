#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
@author: Yangyangli
@contact: li002252@umn.edu
@version: 0.0.1
@license: MIT Licence
@file: find_exon.py
@time: 03/08/2021 21:20
"""
import pandas as pd
import sys


def main(filename, gene):
    df = pd.read_table(filename)

    df_gene = df[df.gene_id == gene]
    df_tp = df_gene[df_gene.transcript_id == f'{gene}_template']
    df_es = df_gene[df_gene.transcript_id == f'{gene}_es']

    t1 = df_tp[df_tp.type == 'exon']
    t2 = df_es[df_es.type == 'exon']
    ind = int(list(set(t1.gene_exon_number) - set(t2.gene_exon_number))[0])
    print(t1.iloc[int(ind) - 2:int(ind) + 1, :])


if __name__ == '__main__':
    filename = sys.argv[1]
    gene = sys.argv[2]
    main(filename=filename, gene=gene)

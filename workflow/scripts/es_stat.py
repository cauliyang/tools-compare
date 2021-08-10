#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
@author: Yangyangli
@contact: li002252@umn.edu
@version: 0.0.1
@license: MIT Licence
@file: es_stat.py
@time: 03/08/2021 21:20
"""
import pandas as pd
import sys
from pathlib import Path


def find_genes(dir, file_name="event_annotation.tsv"):
    df = pd.read_table(dir / file_name)
    genes = [gene.split('_')[0] for gene in df['variant'].values]

    return genes


def es(genes, dir, file_name='exon_junction_coverage.tsv'):
    res = []
    df = pd.read_table(file_name)
    for gene in genes:
        df_gene = df[df.gene_id == gene]
        df_tp = df_gene[df_gene.transcript_id == f'{gene}_template']
        df_es = df_gene[df_gene.transcript_id == f'{gene}_es']
        t1 = df_tp[df_tp.type == 'exon']
        t2 = df_es[df_es.type == 'exon']
        ind = int(list(set(t1.gene_exon_number) - set(t2.gene_exon_number))[0])
        tmp = t1.iloc[int(ind) - 2:int(ind) + 1, 1:3]
        #        print(tmp.iloc[2,:].to_list())
        # check strand
        if tmp.iloc[0, 0] > tmp.iloc[2, 0]:
            exons = [gene, *tmp.iloc[2, :].to_list(), *tmp.iloc[1, :].to_list(), *tmp.iloc[0, :].to_list()]
        else:
            exons = [gene, *tmp.iloc[0, :].to_list(), *tmp.iloc[1, :].to_list(), *tmp.iloc[2, :].to_list()]
        res.append(exons)
    df_res = pd.DataFrame(res, columns=['gene', 'pre_exon_st', 'pre_exon_ed', 'exon_st', 'exon_ed', 'af_exon_st',
                                        'af_exon_ed'])
    df_res.index.name = 'id'
    df_res.to_csv('exon_skipping.csv')
    return df_res.set_index('gene')


def rmats_es(rmats_file_path, df_es):
    # df_es = pd.read_csv(es_file_path, index_col=1)
    df_rmats = pd.read_table(rmats_file_path, index_col=1)
    finished_pool = []
    correct_pool =[]
    for row in df_rmats.iterrows():
        gene = row[0]
        tmp = row[1]
        if gene not in finished_pool:
            df_rmats_info = tmp[['exonStart_0base', 'exonEnd']].values
            df_es_info = df_es.loc[gene, ['exon_st', 'exon_ed']].values
            control = (abs(df_rmats_info[0] - df_es_info[0]) < 2) and (abs(df_rmats_info[1] - df_es_info[1]) < 2)
            print(df_rmats_info, df_es_info, control)
            if control:
                # correct
                finished_pool.append(gene)
                correct_pool.append(tmp)

    correct_rmats = pd.concat(correct_pool, axis=1).T
    correct_rmats.index.name = "gene"
    correct_rmats.to_csv('rmats_correct.csv')


def majiq_es(majiq_file_path, df_es):
    pass 


def spladder_es(file_path, df_es): 
    df = pd.read_table(file_path, index_col = 3)
    finished_pool = []
    correct_pool =[]

    for row in df.iterrows():
        gene = row[0]
        tmp = row[1]
        if (gene not in finished_pool) and (gene in df_es.index):
            df_info = tmp[['exon_start','exon_end']].values
            df_es_info = df_es.loc[gene, ['exon_st', 'exon_ed']].values
            control = (abs(df_info[0] - df_es_info[0]) < 2) and (abs(df_info[1] - df_es_info[1]) < 2)
            print(df_info, df_es_info, control)
            if control:
                # correct
                finished_pool.append(gene)
                correct_pool.append(tmp)

    correct_rmats = pd.concat(correct_pool, axis=1).T
    correct_rmats.index.name = "gene"
    correct_rmats.to_csv('spladder_correct.csv')


if __name__ == '__main__':
    wkdir = Path(sys.argv[1])
    genes = find_genes(wkdir)
    df_es = es(genes, wkdir)
    rmats_es(wkdir/"rmats_fromGTF.novelJunction.SE.txt", df_es)
    spladder_es(wkdir/"merge_graphs_exon_skip_C3.confirmed.txt.gz", df_es)

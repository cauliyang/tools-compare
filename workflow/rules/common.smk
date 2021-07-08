from workflow.scripts.simulator import creat_samples
from snakemake.utils import validate
import pandas as pd
from pathlib import Path

# this container defines the underlying OS for each job when using the workflow
# with --use-conda --use-singularity
singularity: "docker://continuumio/miniconda3"

##### load config and sample sheets #####


creat_samples(config['simulator']['outdir'] + config['simulator']['outname'], "config/samples.tsv")

validate(config, schema="../schemas/config.schema.yaml")

samples = pd.read_csv(config["samples"], sep="\t").set_index("samples", drop=False)

samples.index.names = ["sample_id"]
validate(samples, schema="../schemas/samples.schema.yaml")


WORKING_DIR = config["wkdir"]
RESULT_DIR = config["resultdir"]


def creat_samples(path, config_path):
    files = "sim_rep_info.txt"  # file path of "sim_rep_info.txt"
    path = Path(path)
    # PATH = Path(snakemake.input)  # file path of out of simulation
    #
    # CONFIG_PATH = snakemake.output  # path of config

    sample = pd.read_csv(path / files, sep='\t')
    sample['fq1'] = sample.rep_id.map(lambda x: f'{Path}/{x}_1.fastq')
    sample['fq2'] = sample.rep_id.map(lambda x: f'{Path}/{x}_2.fastq')
    df = sample.loc[:, ['rep_id', 'fq1', 'fq2', 'group']].rename({'rep_id': 'samples'}, axis=1)
    df.to_csv(config_path, index=False, sep='\t')



def get_fastq(wildcards):
    """This function checks if the sample has paired end or single end reads
    and returns 1 or 2 names of the fastq files"""

    return samples.loc[(wildcards.sample), ["fq1", "fq2"]].dropna()


def get_trimmed(wildcards):
    return [
        f"{WORKING_DIR}trimmed/{wildcards.sample}_R1_trimmed.fq.gz",
        f"{WORKING_DIR}trimmed/{wildcards.sample}_R1_trimmed.fq.gz",
    ]

def get_align_result():
    return expand(WORKING_DIR + "mapped/{sample}.sort.bam.bai", sample=samples.index.tolist())


def get_bam():
    return expand(WORKING_DIR + "mapped/{sample}.sort.bam", sample=samples.index.tolist())

#TODO: add a function to generate samples.tsv from simulated directory.
def simulate_samples():
    pass

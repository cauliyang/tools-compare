from snakemake.utils import validate
import pandas as pd


# this container defines the underlying OS for each job when using the workflow
# with --use-conda --use-singularity
singularity: "docker://continuumio/miniconda3"


##### load config and sample sheets #####

validate(config, schema="../schemas/config.schema.yaml")

samples = pd.read_csv(config["samples"], sep="\t").set_index("samples", drop=False)

samples.index.names = ["sample_id"]
validate(samples, schema="../schemas/samples.schema.yaml")


WORKING_DIR = config["wkdir"]
RESULT_DIR = config["resultdir"]


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

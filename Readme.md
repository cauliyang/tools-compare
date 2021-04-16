# 1. Project Description 

The project aim to compare the performance for several kinds of tools used to dectect alternative splicing. The  tools are shown below: 

## 2. Program Plan 

### 2.1  Installation of Software

 - [x] [MISO](http://hollywood.mit.edu/burgelab/miso/) | [Documentation](https://miso.readthedocs.io/en/fastmiso/#using-miso-on-a-cluster)
 - [x]  [rMATs](http://rnaseq-mats.sourceforge.net/index.html) | [Documentation](https://github.com/Xinglab/rmats-turbo/blob/v4.1.1/README.md)
 - [x] [MAJIQ](https://majiq.biociphers.org/) | [Documentation](https://biociphers.bitbucket.io/majiq/MAJIQ.html#builder)
 - [ ] [LeafCutter](https://davidaknowles.github.io/leafcutter/) | [Documentation](https://davidaknowles.github.io/leafcutter/articles/Installation.html)
 - [ ] [SplAdder](https://github.com/ratschlab/spladder) | [Documentation]
 - [ ] [Jum](https://github.com/qqwang-berkeley/JUM) | [Documentation]
 - [ ] [Whippet](https://github.com/timbitz/Whippet.jl) | [Documentation]

### 2.2 Create Test Data 

[ASimulatoR](https://github.com/biomedbigdata/ASimulatoR) is used to create benchmark data to evaluate the performance of the tools mentioned above. 

### 2.3 Test Tools for simple data 
 
- [ ] [MISO](http://hollywood.mit.edu/burgelab/miso/)
- [ ]  [rMATs](http://rnaseq-mats.sourceforge.net/index.html) 
- [ ] [MAJIQ](https://majiq.biociphers.org/)
- [ ] [LeafCutter](https://davidaknowles.github.io/leafcutter/)
- [ ] [SplAdder](https://github.com/ratschlab/spladder)
- [ ] [Jum](https://github.com/qqwang-berkeley/JUM)
- [ ] [Whippet](https://github.com/timbitz/Whippet.jl)

### 2.4 Construct Snakemake Workflow 

[![Snakemake](https://img.shields.io/badge/snakemake-≥5.7.0-brightgreen.svg?style=flat-square)](https://github.com/snakemake/snakemake-wrappers/blob/38ad23b0e4f58ce7dbd8d32612157f449ca02c62/docs/index.rst) is used to construct workflow. 

- [ ] Creat simulated data 
- [ ] Create Rna-align rule 
- [ ] Create Run-tools rules
- [ ] Create evaluation rules 
- [ ] Create report rules 
 
<!--stackedit_data:
eyJoaXN0b3J5IjpbMjA4OTUwMTc5OCwxOTY1ODk2NDEsNjU1Nj
Q5Nzc3LC0xMzg5MTM1Njg5LC00OTAzNzk5ODMsNjYzODI2NzU1
LC0xMzIwNzA4MjksODgzODY3MzcxLC0xNTU5MTEyNTAwLC05Mj
gyMjcwOCwtNTk5ODI0MDA0LDI3MjMzNTUxN119
-->
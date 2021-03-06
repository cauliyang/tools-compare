## <center> 1. Project Description
![](https://cdn.jsdelivr.net/gh/cauliyang/blog-image@main//img/20210417053027.png)   

![](https://img.shields.io/static/v1?label=Python&message=3.6&color=<COLOR>&style=for-the-badge&logo=Python) [![](https://img.shields.io/static/v1?label=Snakemake&message=≥5.7.0&color=<COLOR>&style=for-the-badge&logo=snakemake)](https://github.com/snakemake/snakemake-wrappers/blob/38ad23b0e4f58ce7dbd8d32612157f449ca02c62/docs/index.rst). 


The project aim to compare the performance for several kinds of tools used to dectect alternative splicing. The  tools are shown below: 


## 2. Program Plan 

### 2.1  Installation of Software

 - [x] [MISO](http://hollywood.mit.edu/burgelab/miso/) | [Documentation](https://miso.readthedocs.io/en/fastmiso/#using-miso-on-a-cluster)
 - [x]  [rMATs](http://rnaseq-mats.sourceforge.net/index.html) | [Documentation](https://github.com/Xinglab/rmats-turbo/blob/v4.1.1/README.md)
 - [x] [MAJIQ](https://majiq.biociphers.org/) | [Documentation](https://biociphers.bitbucket.io/majiq/MAJIQ.html#builder)
 - [x] [LeafCutter](https://davidaknowles.github.io/leafcutter/) | [Documentation](https://davidaknowles.github.io/leafcutter/articles/Installation.html)
 - [x] [SplAdder](https://github.com/ratschlab/spladder) | [Documentation](https://spladder.readthedocs.io/en/latest/general.html)
 - [x] [Jum](https://github.com/qqwang-berkeley/JUM) | [Documentation](https://github.com/qqwang-berkeley/JUM/wiki/A-Hitchhiker's-guide-to-JUM-(version-2.0.2-))
 - [x] [Whippet](https://github.com/timbitz/Whippet.jl) | [Documentation](https://github.com/timbitz/Whippet.jl)

**run\_c.sh** records the usage and location of these tools. 

### 2.2 Create Test Data 

[ASimulatoR](https://github.com/biomedbigdata/ASimulatoR) is used to create benchmark data to evaluate the performance of the tools mentioned above.  

- [x] Test using annotation of all chromosomes
- [x] Download genome file for every chromosome
- [x] Creat Simple Test data 
- [x] Construct clean directory


### 2.3 Construct Snakemake Workflow 

[Snakemake](https://github.com/snakemake/snakemake-wrappers/blob/38ad23b0e4f58ce7dbd8d32612157f449ca02c62/docs/index.rst) is used to construct workflow. 

- [x] Creat and Test simulated data  
- [x] Create and Test Rna-align rule 
- [x] Create and Test Run-tools rules
	- [ ] [MISO](http://hollywood.mit.edu/burgelab/miso/) (Skipped)
	- [x] [rMATs](http://rnaseq-mats.sourceforge.net/index.html) 
	- [x] [MAJIQ](https://majiq.biociphers.org/)
	- [ ] [LeafCutter](https://davidaknowles.github.io/leafcutter/)(Skipped)
	- [x] [SplAdder](https://github.com/ratschlab/spladder)
	- [x] [Jum](https://github.com/qqwang-berkeley/JUM)(Skipped)
	- [x] [Whippet](https://github.com/timbitz/Whippet.jl)
- [x] Create evaluation rules 
- [ ] Create report rules 


## 3. Problem 

1. MISO 

MISO cannot detect alternative splicing events. 

2. LeafCutter 

LeafCutter cannot detect alternative splicing events. 

3. Jum 

Jum must need alignment files from STAR 



## 4. Test Tools for data 
 
- [ ] [MISO](http://hollywood.mit.edu/burgelab/miso/)
- [x] [rMATs](http://rnaseq-mats.sourceforge.net/index.html) 
- [x] [MAJIQ](https://majiq.biociphers.org/)
- [ ] [LeafCutter](https://davidaknowles.github.io/leafcutter/)
- [x] [SplAdder](https://github.com/ratschlab/spladder)
- [ ] [Jum](https://github.com/qqwang-berkeley/JUM)
- [x] [Whippet](https://github.com/timbitz/Whippet.jl)

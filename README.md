# β-cell Transcriptome Profiling in Type 2 Diabetes

[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![Build Status](https://github.com/YOURUSER/beta-cell-transcriptome-T2D/actions/workflows/ci.yml/badge.svg)](https://github.com/YOURUSER/beta-cell-transcriptome-T2D/actions)

Reproducible pipeline for **single-cell RNA-seq analysis of pancreatic β-cells** from healthy and Type 2 Diabetes (T2D) donors.  
This project replicates and extends the workflow from [Segerstolpe et al_., *Cell Metabolism* 2016](https://doi.org/10.1016/j.cmet.2016.08.020), using **Nextflow**, **STAR**, and **DESeq2** to profile gene expression changes and β-cell heterogeneity.

---

## 🚀 Motivation
- Type 2 Diabetes affects 1 in 9 individuals worldwide (IDF 2025).  
- β-cells in islets of Langerhans are central to insulin secretion and glucose homeostasis.  
- Bulk RNA-seq misses heterogeneity; **single-cell RNA-seq** resolves subpopulations and disease-related signatures.  

---

## 🎯 Objectives
- Build a reproducible scRNA-seq pipeline (QC → alignment → quantification → DE analysis).  
- Compare transcriptomes of healthy vs T2D β-cells.  
- Identify differentially expressed genes and enriched pathways.  

---

## 📊 Key Results
 
| Analysis | Finding |
|---|---|
| Marker expression | INS significantly lower in T2D β-cells (p < 0.001) |
| Differential expression | GCG, INS, SST all significantly different (p < 0.05) |
| t-SNE clustering | Healthy and T2D β-cells form distinct clusters |
| GSEA | T2D mellitus and insulin resistance pathways enriched |
| Predictive model | Logistic regression (L1) identified 15 top predictive genes |
 
**Top predictive feature:** *IRF2BPL* alongside 9 established T2D risk genes — GCK, CDKAL1, KCNJ11, SLC30A8, IRS1, GLIS3, JAZF1, SLC16A11, SREBF1.
 
## 📂 Repository Structure
```
├── README.md
├── environment.yml                               # Conda environment
├── pipeline.ipynb                                # Master pipeline documentation (start here)
│
├── analysis/                                     # Python analysis notebooks & outputs
│   ├── ensembl_to_ids.ipynb                      # Map Ensembl IDs → gene symbols
│   ├── differential_expression.ipynb             # DE analysis
│   ├── expression_analysis.ipynb                 # Expression plots & GSEA
│   ├── ml_classification.ipynb                   # t-SNE, PCA, logistic regression
│   ├── ANALYSIS_REPORT.md
│   ├── gene_function_ontology.csv
│   ├── t2d_gene_references.pdf
│   └── figures/
│       ├── predictive_genes.png
│       ├── volcano.png
│       ├── tsne_condition.png
│       ├── tsne_donor.png
│       └── reproduced_fig*.png
│
├── pipeline/                                     # HPC pipeline (Nextflow + SLURM)
│   ├── fastq_processing.nf                       # Trimming & QC
│   ├── star_align.nf                             # STAR alignment
│   ├── build_star_index.sh
│   └── shell_scripts/
│       ├── download_all_fastq.sh
│       ├── download_fastq.sh
│       ├── ena_manifest_PRJEB15401.sh
│       └── record_readcounts.sh
│
├── samples/                                      # Sample metadata & download scripts
│   ├── donor_ids.csv
│   ├── ena_filereport.tsv
│   ├── healthy_beta.txt
│   ├── t2d_beta.txt
│   ├── read_counts_all.csv
│   ├── read_counts_filtered.csv
│   ├── donor_samples.ipynb
│   ├── read_counts.ipynb
│   └── create_download_scripts.ipynb
│
├── gene_matrix/                                  # Count matrix generation
│   └── combine_tables.ipynb
│
├── rpkm_values/                                  # RPKM normalization
│   └── calculate_rpkm.R                          # R/edgeR normalization script
│
├── qc_reports/                                   # Quality control
│   ├── multiqc_report.html
│   └── qc_analysis.ipynb
│
├── docs/                                         # Writeups
│   ├── individual_writeup.pdf
│   └── pipeline_scripts.pdf
│
├── presentation/
│   └── presentation_slides.pdf
│
└── bioinformatics-T2D-scRNAseq/                  # Original course submission folder
    ├── code/
    ├── docs/
    └── slides/
```
---

## 🔬 Methods & Tools
- **QC & Preprocessing:** Cutadapt, FastQC, MultiQC  
- **Alignment & Quantification:** STAR, featureCounts  
- **Analysis:** R (DESeq2, clusterProfiler), Python (pandas, matplotlib), NetworkAnalyst  
- **Pipeline Management:** Nextflow, Conda
  
  <img width="1820" height="1104" alt="image" src="https://github.com/user-attachments/assets/4435b935-580b-4f14-9323-747a11d9e9a9" />


---

## ⚡ Quickstart
 
### 1. Set up environment
 
```bash
conda env create -f environment.yml
conda activate islet-scrna-t2d
```
 
### 2. HPC pipeline (requires cluster access)
 
See [`pipeline/README.md`](pipeline/README.md) and [`pipeline.ipynb`](pipeline.ipynb).
 
Requires: STAR v2.3.0e, cutadapt, Nextflow, featureCounts, R/edgeR.
 
### 3. Local analysis (runs on laptop)
 
Open notebooks in this order:
 
1. [`gene_matrix/combine_tables.ipynb`](gene_matrix/combine_tables.ipynb) — merge count matrices
2. [`analysis/ensembl_to_ids.ipynb`](analysis/ensembl_to_ids.ipynb) — map Ensembl → gene IDs
3. [`analysis/differential_expression.ipynb`](analysis/differential_expression.ipynb) — DE analysis
4. [`analysis/expression_analysis.ipynb`](analysis/expression_analysis.ipynb) — expression plots, GSEA
5. [`analysis/ml_classification.ipynb`](analysis/ml_classification.ipynb) — t-SNE, PCA, logistic regression
 
---
 
## 🗂 Data
 
- **Source:** ENA accession [PRJEB15401](https://www.ebi.ac.uk/ena/browser/view/PRJEB15401)
- **Samples:** 142 β-cells — 97 healthy, 45 T2D (after quality filtering)
- **Genes:** 62,710 total → 16,361 expressed in ≥ 5 cells
- **Reference genome:** Homo sapiens GRCh38, Ensembl Release 109
 
> Large intermediate files (count matrices, RPKM tables) are not tracked in git. See subdirectory READMEs for how to regenerate them.
 
---
 
## 📄 References
 
- Segerstolpe Å. et al. (2016). *Single-cell transcriptome profiling of human pancreatic islets in health and type 2 diabetes*. Cell Metabolism, 24(4), 593–607. [DOI](https://doi.org/10.1016/j.cmet.2016.08.020)
- Grenko C. M. et al. (2024). *Single-cell transcriptomic profiling of human pancreatic islets reveals genes responsive to glucose exposure*. Diabetologia, 67(10), 2246–2259. [DOI](https://doi.org/10.1007/s00125-024-06214-4)
- Raghavan V. et al. (2022). *A simple guide to de novo transcriptome assembly and annotation*. Briefings in Bioinformatics, 23(2), bbab563. [DOI](https://doi.org/10.1093/bib/bbab563)
 
---
 
## 🤝 Acknowledgements
 
- Developed collaboratively as part of BINF 6310 (Spring 2025). Contributions from all four group members are gratefully acknowledged.


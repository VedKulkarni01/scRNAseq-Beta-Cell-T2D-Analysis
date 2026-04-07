#!/usr/bin/env bash
# Run this from inside your repo:
#   cd scRNAseq-Beta-Cell-T2D-Analysis
#   bash sync.sh
set -e

echo "==> Adding team remote (if not already added)..."
git remote get-url team 2>/dev/null || git remote add team https://github.com/richgoodier/islet-scrna-t2d.git
git fetch team

echo ""
echo "==> Copying missing files from team repo into your repo..."

# ── Root-level files ──────────────────────────────────────────────────────────
for f in .gitattributes .gitignore CLAUDE.md LICENSE TASKS.md environment.yml pipeline.ipynb; do
  if [ ! -e "$f" ]; then
    git checkout team/master -- "$f"
    echo "  COPIED: $f"
  else
    echo "  SKIP  : $f (already exists)"
  fi
done

# ── analysis/ ─────────────────────────────────────────────────────────────────
mkdir -p analysis/figures

for f in \
  analysis/ANALYSIS_REPORT.md \
  analysis/README.md \
  analysis/differential_expression.ipynb \
  analysis/ensembl_symbol_cache.json \
  analysis/ensembl_to_ids.ipynb \
  analysis/expression_analysis.ipynb \
  analysis/ml_classification.ipynb \
  analysis/gene_function_ontology.csv \
  analysis/t2d_gene_references.pdf \
  "analysis/figures/predictive_genes.png" \
  "analysis/figures/reproduced_fig4Bi.png" \
  "analysis/figures/reproduced_fig4Bii.png" \
  "analysis/figures/reproduced_figS2C.png" \
  "analysis/figures/reproduced_figS2Ca.png" \
  "analysis/figures/reproduced_figS2Cai.png" \
  "analysis/figures/tsne_condition.png" \
  "analysis/figures/tsne_donor.png" \
  "analysis/figures/tsne_donor_top50.png" \
  "analysis/figures/volcano.png"; do
  if [ ! -e "$f" ]; then
    git checkout team/master -- "$f"
    echo "  COPIED: $f"
  else
    echo "  SKIP  : $f (already exists)"
  fi
done

# ── gene_matrix/ ──────────────────────────────────────────────────────────────
mkdir -p gene_matrix
for f in gene_matrix/README.md gene_matrix/combine_tables.ipynb; do
  if [ ! -e "$f" ]; then
    git checkout team/master -- "$f"
    echo "  COPIED: $f"
  else
    echo "  SKIP  : $f (already exists)"
  fi
done

# ── pipeline/ ─────────────────────────────────────────────────────────────────
mkdir -p pipeline/shell_scripts
for f in \
  pipeline/README.md \
  pipeline/build_star_index.sh \
  pipeline/fastq_processing.nf \
  pipeline/star_align.nf \
  pipeline/shell_scripts/download_all_fastq.sh \
  pipeline/shell_scripts/download_fastq.sh \
  pipeline/shell_scripts/ena_manifest_PRJEB15401.sh \
  pipeline/shell_scripts/record_readcounts.sh; do
  if [ ! -e "$f" ]; then
    git checkout team/master -- "$f"
    echo "  COPIED: $f"
  else
    echo "  SKIP  : $f (already exists)"
  fi
done

# ── qc_reports/ ───────────────────────────────────────────────────────────────
mkdir -p qc_reports
for f in qc_reports/README.md qc_reports/multiqc_report.html; do
  if [ ! -e "$f" ]; then
    git checkout team/master -- "$f"
    echo "  COPIED: $f"
  else
    echo "  SKIP  : $f (already exists)"
  fi
done

# ── docs/ ─────────────────────────────────────────────────────────────────────
mkdir -p docs
for f in docs/individual_writeup.pdf docs/pipeline_scripts.pdf; do
  if [ ! -e "$f" ]; then
    git checkout team/master -- "$f"
    echo "  COPIED: $f"
  else
    echo "  SKIP  : $f (already exists)"
  fi
done

# ── presentation/ ─────────────────────────────────────────────────────────────
mkdir -p presentation
if [ ! -e "presentation/presentation_slides.pdf" ]; then
  git checkout team/master -- presentation/presentation_slides.pdf
  echo "  COPIED: presentation/presentation_slides.pdf"
else
  echo "  SKIP  : presentation/presentation_slides.pdf (already exists)"
fi

echo ""
echo "==> All files synced. Committing..."

git add -A
git commit -m "sync: add missing files from team repo (richgoodier/islet-scrna-t2d)

Added notebooks, figures, pipeline scripts, QC reports, and docs
that were present in the shared team repo but missing here.
Existing files (bioinformatics-T2D-scRNAseq/) were not overwritten."

echo ""
echo "==> Done! Now push with:"
echo "    git push origin main"

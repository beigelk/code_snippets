#!/bin/bash

# Calculate the average coverage around a 1kb region of a SNP (ChIPseq data)

# SNP positions (snps.bed)
# Load file (formatted as below)
# With the SNP regions
# chrom	chromStart	chromEnd	name
# 1	100	100	snp1
# 2	250	250	snp2
# 2	400	400	snp3
#   ...


# Run as `bam_coverage_snp_region.sh sample.bam`

echo $1


# Get the reads around each SNP position from the BAM fies
# extract reads from the bam file that overlap with the SNP regions
# using `samtools view`
#   -bh: output in bam format (b) with header (h)
#   -L: Only output alignments overlapping the input BED file (--target-file)
samtools view --threads 8 -bh ${1}.bam -L snps_1kb_regions.bed > out/${1}_region_reads_SNPs.bam


# `bedtools coverage` to calculate coverage
# Results:
# After each interval in A, bedtools coverage will report:
  # 1. The number of features in B that overlapped (by at least one base pair) the A interval.
  # 2. The number of bases in A that had non-zero coverage from features in B.
  # 3. The length of the entry in A.
  # 4. The fraction of bases in A that had non-zero coverage from features in B.
  
bedtools coverage -a snps_1kb_regions.bed -b ${1}_region_reads_SNPs.bam -bed > out/coverage_results/${1}_coverage_results.bed


# Alternatively, to get per-base of coverage for each feature in the A file:
# https://bedtools.readthedocs.io/en/latest/content/tools/coverage.html?highlight=coverage#d-reporting-the-per-base-of-coverage-for-each-feature-in-the-a-file

# bedtools coverage -a snps_1kb_regions.bed -b ${1}_region_reads_SNPs.bam -bed -d > out/coverage_results_depth/${1}_coverage_results_depth.bed




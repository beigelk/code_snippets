#!/bin/bash

# SNP positions (snps.bed)
# Load file (formatted as below)
# With the SNP regions
# chrom	chromStart	chromEnd	name
# 1	100	100	snp1
# 2	250	250	snp2
# 2	400	400	snp3
#   ...

# `bedtools slop` to extend SNP regions to 1kb
# https://bedtools.readthedocs.io/en/latest/content/tools/slop.html
bedtools slop -i snps.bed -g hg38/hg38.chrom.sizes -b 500 > snps_1kb_regions.bed

#!/bin/bash

# SET UP FILE NEEDED: text file dirnames.txt is a text file where each line is the path up to
# the base name for the sample. See dirnames.txt for example.

# Need to set internal field separator to properly construct the cat command
# otherwise it may use the space in some filenames as field serparator and
# make a newline in the middle of first string in cat

IFS=$'\n'

for path_sample in `cat ./dirnames.txt `; do
				
				# Replace everything before the first slash with nothing (get just the sample ID)
        sample_name=$(echo $path_sample | sed 's|.*/||')
        echo '-------------------- PROCESSING ' $sample_name '-----------------------'
				
				# Capture everything before the first slash
        path=$(echo $path_sample | sed 's|\(.*\)/.*|\1|')

        R1_files=$(find $path -type f -name "${sample_name}_L00*_R1_001.fastq.gz" | sort -n)
        R2_files=$(find $path -type f -name "${sample_name}_L00*_R2_001.fastq.gz" | sort -n)

        echo 'R1 files:' $R1_files
      	echo cat $R1_files \> 00_concat/${sample_name}_R1.fastq.gz >> concat.log
      	cat $R1_files > 00_concat/${sample_name}_R1.fastq.gz
              
      	
      	echo 'R2 files:' $R2_files
      	echo cat $R2_files \> 00_concat/${sample_name}_R2.fastq.gz >> concat.log
        cat $R2_files > 00_concat/${sample_name}_R2.fastq.gz;

done

# Set IFS back to default
unset IFS

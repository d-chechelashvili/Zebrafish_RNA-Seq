#!/bin/bash

# Array of accession numbers for the zebrafish experiment
zebrafishaccessions="SRR633516 SRR633540 SRR633541 SRR633542 SRR633543 SRR633549 SRR633548 SRR633547 SRR633546 SRR633544 SRR633545"

workflow() {
    local f=$1
    echo "Processing $f"
    repair.sh in1=/mnt/c/Users/david/Desktop/zebrafish/files/preprocessed/"$f"_fastp_1.fastq in2=/mnt/c/Users/david/Desktop/zebrafish/files/preprocessed/"$f"_fastp_2.fastq out1=/mnt/c/Users/david/Desktop/zebrafish/files/preprocessed/"$f"_fastp_1_fixed.fastq out2=/mnt/c/Users/david/Desktop/zebrafish/files/preprocessed/"$f"_fastp_2_fixed.fastq outsingle=/mnt/c/Users/david/Desktop/zebrafish/files/preprocessed/"$f"_fastp_single.fastq repair
    echo "Done processing $f"
}

for f in $zebrafishaccessions
do
   workflow "$f"
done

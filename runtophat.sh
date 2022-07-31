#!/bin/bash

# Array of accession numbers for the zebrafish experiment
zebrafishaccessions="SRR633516 SRR633540 SRR633541 SRR633542 SRR633543 SRR633549 SRR633548 SRR633547 SRR633546 SRR633544 SRR633545"

workflow() {
    local f=$1
    echo "Processing $f"
    tophat --segment-mismatches 1 --segment-length 13 --no-coverage-search /mnt/c/Users/david/Desktop/zebrafish/files/reference/Danio_rerio.GRCz11.dna_rm.primary_assembly /mnt/c/Users/david/Desktop/zebrafish/files/preprocessed/"$f"_prinseq_1.fastq  /mnt/c/Users/david/Desktop/zebrafish/files/preprocessed/"$f"_prinseq_2.fastq -o /mnt/c/Users/david/Desktop/zebrafish/files/tophat/tophat_2-"$f"
    echo "Done Processing $f"
}

for f in $zebrafishaccessions
do
   workflow "$f"
done

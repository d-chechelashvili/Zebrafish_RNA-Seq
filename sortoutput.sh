#!/bin/bash

# Array of accession numbers for the zebrafish experiment
zebrafishaccessions="SRR633516 SRR633540 SRR633541 SRR633542 SRR633543 SRR633549 SRR633548 SRR633547 SRR633546 SRR633544 SRR633545"

workflow() {
    local f=$1
    echo "Processing $f"
    samtools sort -o /mnt/c/Users/david/Desktop/zebrafish/files/hisat/hisat_2-"$f".sorted.bam /mnt/c/Users/david/Desktop/zebrafish/files/hisat/hisat_2-"$f".sam
    echo "Done Processing $f"
}

for f in $zebrafishaccessions
do
   workflow "$f" &
done

#!/bin/bash

# Array of accession numbers for the zebrafish experiment
zebrafishaccessions="SRR633516 SRR633540 SRR633541 SRR633542 SRR633543 SRR633549 SRR633548 SRR633547 SRR633546 SRR633544 SRR633545"

workflow() {
    local f=$1
    echo "Processing $f"
    fastp -i /mnt/c/Users/david/Desktop/zebrafish/files/"$f"_1.fastq -o /mnt/c/Users/david/Desktop/zebrafish/files/preprocessed/"$f"_fastp_1.fastq -I /mnt/c/Users/david/Desktop/zebrafish/files/"$f"_2.fastq -O /mnt/c/Users/david/Desktop/zebrafish/files/preprocessed/"$f"_fastp_2.fastq -3 20 -5 20 -q 20 -l 25 -x -n 3 -c 
    echo "Done processing $f"
}

for f in $zebrafishaccessions
do
   workflow "$f"
done

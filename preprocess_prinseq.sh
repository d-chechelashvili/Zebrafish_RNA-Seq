#!/bin/bash

# Array of accession numbers for the zebrafish experiment
zebrafishaccessions="SRR633516 SRR633540 SRR633541 SRR633542 SRR633543 SRR633549 SRR633548 SRR633547 SRR633546 SRR633544 SRR633545"

workflow() {
    local f=$1
    prinseq-lite.pl -fastq /mnt/c/Users/david/Desktop/project/project/files/"$f"_1.fastq -fastq2 /mnt/c/Users/david/Desktop/zebrafish/files/"$f"_2.fastq -trim_ns_left 1 -trim_ns_right 1 -min_qual_score 20 -trim_qual_left 20 -trim_qual_right 20 -trim_qual_type min -min_len 25 -out_good /mnt/c/Users/david/Desktop/zebrafish/files/"$f"_prinseq -out_format 3
}

for f in $zebrafishaccessions
do
   workflow "$f" &
done

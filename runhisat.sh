#!/bin/bash

# Array of accession numbers for the zebrafish experiment
# zebrafishaccessions="SRR633516 SRR633540 SRR633541 SRR633542 SRR633543 SRR633549 SRR633548 SRR633547 SRR633546 SRR633544 SRR633545"

workflow() {
    local f=$1
    hisat2 -p 6 -x /mnt/c/Users/david/Desktop/zebrafish/files/reference/index/Danio_rerio.GRCz11.dna_rm.primary_assembly -1 /mnt/c/Users/david/Desktop/zebrafish/files/preprocessed/"$f"_fastp_1_fixed.fastq -2 /mnt/c/Users/david/Desktop/zebrafish/files/preprocessed/"$f"_fastp_2_fixed.fastq -S /mnt/c/Users/david/Desktop/zebrafish/files/hisat/hisat_2-"$f".sam --dta --known-splicesite-infile /mnt/c/Users/david/Desktop/zebrafish/files/reference/splicesites.txt
}

start_time=$SECONDS
for f in $zebrafishaccessions
do

   echo "Processing $f"
   workflow "$f"
   echo "Done Processing $f"
done
# powershell.exe '[console]::beep(400,900)'
elapsed=$(( SECONDS - start_time ))
eval "echo Elapsed time: $(date -ud "@$elapsed" +'$((%s/3600/24)) days %H hr %M min %S sec')"

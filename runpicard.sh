#!/bin/bash

# Array of accession numbers for the zebrafish experiment
zebrafishaccessions="SRR633516 SRR633540 SRR633541 SRR633542 SRR633543 SRR633549 SRR633548 SRR633547 SRR633546 SRR633544 SRR633545"

workflow() {
    local f=$1
    picard CollectAlignmentSummaryMetrics R=/mnt/c/Users/david/Desktop/zebrafish/files/reference/Danio_rerio.GRCz11.dna_rm.primary_assembly.fa I=/mnt/c/Users/david/Desktop/zebrafish/files/hisat/hisat_2-"$f".sorted.bam O=/mnt/c/Users/david/Desktop/zebrafish/files/picard/picard_"$f".txt
}

start_time=$SECONDS
for f in $zebrafishaccessions
do
   echo "Processing $f"
   workflow "$f"
   echo "Done Processing $f"
done
python3 beautify_tablefiles.py /mnt/c/Users/david/Desktop/zebrafish/files/picard/
# powershell.exe '[console]::beep(400,900)'
elapsed=$(( SECONDS - start_time ))
eval "echo Elapsed time: $(date -ud "@$elapsed" +'%H hr %M min %S sec')"

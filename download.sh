#!/bin/bash
# Array of accession numbers for the zebrafish experiment
zebrafishaccessions="SRR633516 SRR633540 SRR633541 SRR633542 SRR633543 SRR633549 SRR633548 SRR633547 SRR633546 SRR633544 SRR633545"

workflow () {
    local f=$1
    echo "Downloading $f"
    fastq-dump "$f" --split-files -O /mnt/c/Users/david/Desktop/zebrafish/files -I -F
    sed -i '/^+HW/ s/$/\/1/' /mnt/c/Users/david/Desktop/zebrafish/files/"$f"_1.fastq
    sed -i '/^+HW/ s/$/\/2/' /mnt/c/Users/david/Desktop/zebrafish/files/"$f"_2.fastq
    sed -i '/^@HW/ s/$/\/1/' /mnt/c/Users/david/Desktop/zebrafish/files/"$f"_1.fastq
    sed -i '/^@HW/ s/$/\/2/' /mnt/c/Users/david/Desktop/zebrafish/files/"$f"_2.fastq
    echo "Downloaded $f"
}

for f in $zebrafishaccessions
do
   workflow "$f" &
done

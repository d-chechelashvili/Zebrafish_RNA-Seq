#!/bin/bash

start_time=$SECONDS
ls -1 /mnt/c/Users/david/Desktop/zebrafish/files/stringtie/stringtie_* > /mnt/c/Users/david/Desktop/zebrafish/files/stringtie/stringtiefiles.txt
stringtie --merge -G /mnt/c/Users/david/Desktop/zebrafish/files/reference/Danio_rerio.GRCz11.107.gtf -p 4 -o /mnt/c/Users/david/Desktop/zebrafish/files/stringtie/merged.gtf /mnt/c/Users/david/Desktop/zebrafish/files/stringtie/stringtiefiles.txt
# powershell.exe '[console]::beep(400,900)'
elapsed=$(( SECONDS - start_time ))
eval "echo Elapsed time: $(date -ud "@$elapsed" +'%H hr %M min %S sec')"

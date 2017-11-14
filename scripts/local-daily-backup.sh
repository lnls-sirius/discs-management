#!/bin/bash

DISCS_PATH=/home/fac_files/lnls-sirius/discs-management
REMOTE_PATH=fernando-linux:/home/fac_files/backups/discs/daily/

if [ -d  $DISCS_PATH ]; then
    cd $DISCS_PATH
    ./discs-run.sh backup
    find ./backup-files -mtime +30 -type f -delete
    scp -rp  backup-files/*$(date "+%Y-%m-%d")*.gz $REMOTE_PATH
fi

#!/bin/bash

source ~/.bashrc

DISCS_PATH=$ROOT_GROUP/backups/discs
REMOTE_PATH=fernando-linux:/home/fac_files/backups/discs/daily/

if [ -d  $DISCS_PATH ]; then
    cd $DISCS_PATH
    sirius-discs-manager.sh backup
    find ./ -mtime +30 -type f -delete
    scp -rp  *$(date "+%Y-%m-%d")*.gz $REMOTE_PATH
fi

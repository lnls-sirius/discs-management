#!/bin/bash

source ~/.bashrc
export PATH=/usr/local/bin:$PATH

DISCS_PATH=$ROOT_GROUP/backups/discs
REMOTE_PATH=fernando-linux:$ROOT_GROUP/backups/discs/daily/

if [ -d  $DISCS_PATH ]; then
    cd $DISCS_PATH
    sirius-discs-manager.sh backup
    find ./ -mtime +30 -type f -delete
    scp -rp  *$(date "+%Y-%m-%d")*.gz $REMOTE_PATH
fi

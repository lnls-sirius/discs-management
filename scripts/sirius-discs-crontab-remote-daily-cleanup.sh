#!/bin/bash

source ~/.bashrc
export PATH=/usr/local/bin:$PATH

BKUP_PATH=$ROOT_GROUP/backups/discs/daily

if [ -d  $BKUP_PATH ]; then
    cd $BKUP_PATH
    find ./ -mtime +30 -type f -delete
fi

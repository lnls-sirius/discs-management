#!/bin/bash

source ~/.bashrc

BKUP_PATH=$ROOT_GROUP/backups/discs/daily

if [ -d  $BKUP_PATH ]; then
    cd $BKUP_PATH
    find ./ -mtime +30 -type f -delete
fi

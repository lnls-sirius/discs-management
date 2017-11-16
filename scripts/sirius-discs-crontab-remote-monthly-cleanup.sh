#!/bin/bash

source ~/.bashrc
export PATH=/usr/local/bin:$PATH

BKUP_PATH=$ROOT_GROUP/backups/discs/monthly

if [ -d  $BKUP_PATH ]; then
    cd $BKUP_PATH
    find ./ -mtime +365 -type f -delete
fi

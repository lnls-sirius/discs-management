#!/bin/bash

BKUP_PATH=/home/fac_files/backups/discs/monthly

if [ -d  $BKUP_PATH ]; then
    cd $BKUP_PATH
    find ./ -mtime +365 -type f -delete
fi

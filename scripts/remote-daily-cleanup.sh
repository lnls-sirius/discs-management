#!/bin/bash

BKUP_PATH=/home/fac_files/backups/discs/daily

if [ -d  $BKUP_PATH ]; then
    cd $BKUP_PATH
    find ./ -mtime +30 -type f -delete
fi
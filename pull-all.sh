#!/usr/bin/env bash


currentPath=$(pwd -P)
path="$1"
logfile="./git-sync-log/$(date +%Y-%m-%d:%H:%M:%S)-pull.log"

#takes all folder in provided folder and run the pull.sh against each onet-sync-log
for folder in $path/*/ ; do
    sh "$currentPath"/pull.sh $folder | tee -a $logfile
done


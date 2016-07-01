#!/usr/bin/env bash

currentPath="$(dirname "$0")"
path="$1"
logfile="$currentPath/logs/$(date +%Y-%m-%d:%H:%M:%S)-pull.log"

mkdir -p $currentPath/logs

#takes all folder in provided folder and run the pull.sh against each onet-sync-log
for folder in $path/*/ ; do
    sh "$currentPath"/pull.sh $folder | tee -a $logfile
done


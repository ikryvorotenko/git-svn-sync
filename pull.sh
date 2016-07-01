#!/usr/bin/env bash

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

path=$1
cd $path

echo "${RED}[INFO] Started processing $path${NC}"

currentBranch=$(git rev-parse --abbrev-ref HEAD)

git checkout master
git pull

echo "[INFO] checking out svnsync branch"
git checkout svnsync
echo "[INFO] fetching svn commits"
fetch=$(git svn fetch)

#if the fetch returns nothing, exit the script
if [ -z "$fetch" ]; then
    echo "${YELLOW}[WARN] Nothing to fetch from SVN for $path ${NC}\n"
    git checkout master
    exit 0
fi

echo "[INFO] pulling svn commits"
git svn rebase

echo "[INFO] checking out master"
git checkout master
echo "[INFO] merging svncync branch into master"
git merge svnsync --no-edit

echo "[INFO] pushing changes"
git push

echo "\n${GREEN}[INFO] The $path was successfully${NC}"

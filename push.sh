#!/usr/bin/env bash

#example sh ./push ./mi-masterdata "Added some commit"

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

path="$1"
commitMessage="$2"

echo "${RED}[INFO] Started committing to $path${NC}"
cd $path

git checkout master
git pull

git checkout svnsync
git merge --no-ff master -m "$commitMessage"
git svn dcommit

git checkout master
git merge svnsync
git push

echo "${RED}[INFO] Finished committing to $path${NC}"

#!/bin/bash

# check if your git repo is behind remote master and then does `ls`
# I sometimes use it as a replacement of `ls`

ALERT='\033[0;31m'
NC='\033[0m'

if git rev-parse --git-dir > /dev/null 2>&1 ; then
  # current directory is git
  LOCAL=$(git rev-parse @)
  REMOTE=$(git rev-parse @{u} 2> /dev/null)
  if [ $? -ne 0 ]; then
    # remote branch doesn't exist, sh...
    REMOTE=$LOCAL
  fi
  BASE=$(git merge-base @ @{u} 2> /dev/null)

  if [ $LOCAL = $REMOTE ]; then :
  elif [ $LOCAL = $BASE ]; then
    echo -e "${ALERT}Your branch is behind origin/master.${NC}\n======"
  elif [ $REMOTE = $BASE ]; then
    echo -e "${ALERT}Your branch is ahead of origin/master.${NC}\n======"
  else
    echo -e "${ALERT}Your branch and origin/master have diverged.${NC}\n======"
  fi
fi

ls -CF

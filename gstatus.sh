#!/bin/bash
# gstatus.sh -- should use bash (or ksh?)
# based on git-note-taking at: 
# https://www.xypnox.com/blag/posts/moving-notes-to-github/

gstatus=`git status --porcelain`

if [ ${#gstatus} -ne 0 ]
then

  git add --all
  git commit -m "$gstatus"
  git pull
  git push

fi

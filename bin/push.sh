#!/bin/bash
echo "Please enter a comment for what you are committing: "
read mycomment
cd ../admin
git init .
git add *.sh
git commit -m "$mycomment"
git remote add admin ssh://admin@52.87.156.205/git/admin
git push --set-upstream admin admin


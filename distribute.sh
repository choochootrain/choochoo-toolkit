#!/bin/sh

FILES=$(ls -d */ | grep -v '\.git' | grep -v '_.*') 
for dir in $FILES; do
  cd $dir
  echo "Updating $dir configuration"
  ./setup.sh
  cd ..
done

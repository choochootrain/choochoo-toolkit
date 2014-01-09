#!/bin/sh

echo -e "#\n#Edit list of configs to be installed below:\n#" > .install
FILES=$(ls -d */ | grep -v '\.git' | grep -v '_.*') 
for dir in $FILES; do
  echo $dir >> .install
done

$EDITOR .install

for dir in $(cat .install | grep -v '#'); do
  cd $dir
  echo "Updating $dir configuration"
  ./setup.sh
  cd ..
done

rm .install

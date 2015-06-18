#!/bin/sh
ln -sf `pwd`/vimrc ~/.vimrc
mkdir -p ~/.vim/bundle
ln -sf `pwd`/vundle ~/.vim/bundle/vundle
vim +PluginInstall +qall

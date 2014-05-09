#!/bin/sh
ln -sf `pwd`/vimrc ~/.vimrc
ln -sf `pwd`/vundle ~/.vim/bundle/vundle
vim +PluginInstall +qall

#!/bin/sh
ln -sf `pwd`/xmobarrc ~/.xmobarrc
ln -sf `pwd`/resources ~/.xmobar
# TODO fix symlink loop
rm resources/resources

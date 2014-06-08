#!/bin/sh
ln -sf `pwd`/volume.sh ~/bin/volume.sh
ln -sf `pwd`/pop.wav ~/.config/sounds/pop.wav
ln -sf `pwd`/xmonad.hs ~/.xmonad/xmonad.hs
xmonad --recompile

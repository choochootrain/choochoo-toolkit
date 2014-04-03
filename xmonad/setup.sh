#!/bin/sh
ln -sf `pwd`/xmonad.hs ~/.xmonad/xmonad.hs
xmonad --recompile

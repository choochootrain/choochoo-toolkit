#!/bin/sh
ln -sf `pwd`/xmonad.hs ~/.xmonad/xmonad.hs
ln -sf `pwd`/xmonad.hs.bak ~/.xmonad/xmonad.hs.bak
xmonad --recompile

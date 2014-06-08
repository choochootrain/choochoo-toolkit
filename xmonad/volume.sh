#!/bin/sh
case $1 in
  'up')
    amixer set Master 5%+ unmute
    ;;
  'down')
    amixer set Master 5%- unmute
    ;;
  'toggle')
    amixer set Master toggle
    ;;
esac

aplay ~/.config/sounds/pop.wav

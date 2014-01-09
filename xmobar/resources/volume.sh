#!/bin/sh
vol=$(amixer get Master | tail -n 1 | tr -d '[]%' | awk '{print $4 " " $6}')
ret=$(echo "$vol" | cut -f1 -d' ')
stat=$(echo "$vol" | cut -f2 -d' ')
case $stat in
  'on')
    echo "<fc=#3388FF><icon=/home/hp/.xmobar/spkr-on.xbm/></fc> <fc=#00FF00>$ret</fc>%"
    ;;
  'off')
    echo "<fc=#3388FF><icon=/home/hp/.xmobar/spkr-off.xbm/></fc> $ret%"
    ;;
esac

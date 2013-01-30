#!/bin/sh
#

volume() {
  case $1 in
  up)
    amixer -q set Master 5%+ unmute
    ;;
        down)
    amixer -q set Master 5%- unmute
    ;;
  toggle)
          amixer -q set Master toggle
                ;;
  *)
    ;;
  esac;
}

bar() {
    /home/hp/bin/bar "$@"
}

volume $1

VOLUME_TEXT=$(amixer get Master | sed -n '5p' | awk '/Playback/ { print $4 }')
VOLUME_NUM=$(echo $VOLUME_TEXT | sed 's/%//g' | sed 's/\[//g' | sed 's/\]//g')
BCSCRIPT="scale=0;a=$VOLUME_NUM/10;print a+1"
VOLUME=`echo $BCSCRIPT | bc -l`
BCSCRIPT="scale=0;a=10-$VOLUME;print a+1"
BLANK=`echo $BCSCRIPT | bc -l`
STATUS=$(amixer get Master | sed -n '5p' | awk '/Playback/ { print $6 }')

#NUMS="$(seq -s "_" $BLANK | sed 's/[0-9]//g')$(seq -s "█" $VOLUME | sed 's/[0-9]//g')"

twmnc -c "$(bar $VOLUME $BLANK) $VOLUME_TEXT $STATUS" --id 789 -d 10

#!/bin/sh
#

brightness() {
  case $1 in
  up)
          xbacklight -inc 15
    ;;
        down)
                xbacklight -dec 15
    ;;
  *)
    ;;
  esac;
}

bar() {
    /home/hp/bin/bar "$@"
}

brightness $1

BRIGHTNESS=$(xbacklight -get)
BCSCRIPT="scale=0;a=$BRIGHTNESS/5*5;print a"
BRIGHTNESS_NUM=`echo $BCSCRIPT | bc -l`
BCSCRIPT="scale=0;a=$BRIGHTNESS/10;print a"
NUM=`echo $BCSCRIPT | bc -l`
BCSCRIPT="scale=0;a=10-$NUM;print a"
BLANK=`echo $BCSCRIPT | bc -l`
#STATUS=$(amixer get Master | sed -n '5p' | awk '/Playback/ { print $6 }')

#NUMS="$(seq -s "_" $BLANK | sed 's/[0-9]//g')$(seq -s "█" $VOLUME | sed 's/[0-9]//g')"

twmnc -c "$(bar $NUM $BLANK) $BRIGHTNESS_NUM" --id 788 -d 10

#!/bin/bash
# baraction.sh for spectrwm status bar
# From http://wiki.archlinux.org/index.php/Scrotwm

bar() {
    /home/hp/bin/bar "$@"
}

SLEEP_SEC=5
#loops forever outputting a line every SLEEP_SEC secs
while :; do

  POWER_PERCENT=$(acpi | awk '/Battery 0: / { print $4 }' | sed 's/,//g')
  POWER_NUM=$(echo $POWER_PERCENT | sed 's/%//g')
  BCSCRIPT="scale=0;a=$POWER_NUM/10;print a"
  BAR_NUM=`echo $BCSCRIPT | bc -l`
  BCSCRIPT="a=10-$BAR_NUM;print a"
  EMPTY_NUM=`echo $BCSCRIPT | bc -l`
  POWER_STR="$(bar $BAR_NUM $EMPTY_NUM) $POWER_PERCENT"

  WLAN_STR=$(iwconfig wlan0 | awk -F "\"" '/wlan0/ { print $2 }')

  DATE_STR=$(TZ='America/Los_Angeles' date)

  echo -E "    $WLAN_STR    $POWER_STR    $DATE_STR"

  sleep $SLEEP_SEC
done

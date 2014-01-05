#!/bin/bash
# baraction.sh for spectrwm status bar
# From http://wiki.archlinux.org/index.php/Scrotwm

split() {
    BC="scale=0;a=$1/($2/$3);print a"
    echo `echo $BC | bc -l`
}

icon() {
    echo "^i($ICONS/$1.xbm)"
}

color() {
    echo "^fg($1)"
}

brightness() {
  BACKLIGHT=$(xbacklight -get)
  BRIGHTNESS=$(printf "%.0f" $BACKLIGHT)
  COLOR=$FG
  echo "$(color $FG)$(icon sun) $(color $GY)$BRIGHTNESS%"
}

wifi() {
    WLAN=$(iwconfig wlan0 | awk -F "\"" '/wlan0/ { print $2 }')
    echo "$(color $FG)$(icon wifi) $(color $GY)$WLAN"
}

power() {
    POWER=$(acpi | awk '/Battery 0: / { print $4 }' | sed 's/%//g' | sed 's/,//g')
    STATUS=$(acpi | awk '/Battery 0: / { print $3 }' | sed 's/,//g')
    ICON=''
    COLOR=$FG
    case $STATUS in
    'Discharging')
        case `split $POWER 100 4` in
        0)
            ICON=$(icon battery-empty)
            COLOR=$RD
            ;;
        1)
            ICON=$(icon battery-critical)
            COLOR=$OG
            ;;
        2)
            ICON=$(icon battery-low)
            ;;
        *)
            ICON=$(icon battery-full)
            ;;
        esac;
        ;;
    *)
        case $POWER in
        100)
            ICON=$(icon ac-charged)
            ;;
        *)
            ICON=$(icon ac-charging)
            ;;
        esac;
        ;;
    esac;
    echo "$(color $COLOR)$ICON $(color $GY)$POWER%"
}

volume() {
    LINE=$(amixer get Master | sed -n '5p')
    VOLUME=$(echo $LINE | awk '/Playback/ { print $4 }' | sed 's/\[\|\]//g')
    STATUS=$(echo $LINE | awk '/Playback/ { print $6 }')
    ICON=''
    COLOR=''
    case $STATUS in
    '[on]')
        ICON=$(icon spkr-on)
        COLOR=$FG
        ;;
    '[off]')
        ICON=$(icon spkr-off)
        COLOR=$GY
        ;;
    esac;
    echo "$(color $COLOR)$ICON $(color $GY)$VOLUME"
}

datetime() {
    DATETIME=$(TZ='America/Los_Angeles' date | tr -s ' ' | cut -d\  -f1,2,3,4)
    echo "$(color $FG)$(icon clock) $(color $GY)$DATETIME"
}


SLEEP_SEC=1
FG=`cat /home/hp/.config/colorscheme/fg`
BG='#0F0F0F'
GY='#839496'
RD='#d22626'
OG='#b58900'
FONT='-*-terminus-*-r-normal-*-*-100-*-*-*-*-iso8859-*'
ICONS='/home/hp/.config/dzen2'
HEIGHT='16'

killall dzen2

echo -e " $(icon arch) $(color $GY)arch$(color $FG)linux" | dzen2 -p -e - -h $HEIGHT -w '100' -ta l -fg $FG -bg $BG -fn $FONT &

loops forever outputting a line every SLEEP_SEC secs
while :; do
  echo -E "$(volume)    $(power)    $(datetime) "

  sleep $SLEEP_SEC
done | dzen2 -x 800 -e - -h $HEIGHT -w '566' -ta r -fg $FG -bg $BG -fn $FONT &

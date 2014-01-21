#!/bin/sh
#

monitor() {
  case $1 in
  hdmi)
    xrandr --output LVDS1 --auto --output HDMI1 --auto --right-of LVDS1
    ;;
  vga)
    xrandr --output LVDS1 --auto --output VGA1 --auto --left-of LVDS1
    ;;
  off)
    xrandr --output VGA1 --off
    xrandr --output HDMI1 --off
    ;;
  *)
    ;;
  esac;
}

monitor $1

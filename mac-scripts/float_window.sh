#!/usr/bin/env bash

MIN_WIDTH=2000
DISPLAY_WIDTH=$(yabai -m query --displays --display | jq '.frame.w | tonumber | floor')

yabai -m window --toggle float

if [[ "$DISPLAY_WIDTH" -gt $MIN_WIDTH ]]; then
    yabai -m window --grid 1:5:1:1:3:2
else
    yabai -m window --grid 9:9:1:1:7:7
fi

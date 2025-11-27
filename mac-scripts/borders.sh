#!/usr/bin/env bash

ACTIVE_COLOR="0xcc00cccc"
INACTIVE_COLOR="0x00000000"
WIDTH="8"

if [ -n "$1" ]; then
    case $1 in
        default)
        ;;
        resize)
            ACTIVE_COLOR="0xffff00ff"
        ;;
        monitor)
            ACTIVE_COLOR="0xff00ff33"
        ;;
        service)
            ACTIVE_COLOR="0xffffff00"
        ;;
        clear)
            ACTIVE_COLOR="$INACTIVE_COLOR"
        ;;
        *)
            ACTIVE_COLOR="$1"
        ;;
    esac
fi

$(borders "active_color=${ACTIVE_COLOR}" "inactive_color=${INACTIVE_COLOR}" "width=${WIDTH}")

#!/usr/bin/env bash

# https://github.com/Julian-Heng/chunkwm-config/blob/master/chunkwm/scripts/misc/open_iTerm2.sh
# Detects if iTerm2 is running
if ! pgrep -f "iTerm" > /dev/null; then
    open "/Applications/iTerm.app"
else
    # Create a new window
    if ! osascript -e 'tell application "iTerm2" to create window with default profile' > /dev/null; then
        # Get pids for any app with "iTerm" and kill
        for i in $(pgrep -f "iTerm"); do kill -15 "$i"; done
        open "/Applications/iTerm.app"
    fi
fi

#!/usr/bin/env bash

kitty --detach bluetui

sleep 0.5

WINDOW=$(hyprctl -j clients | jq -r '.[] | select(.title == "bluetui") | .address')

if [ -n "$WINDOW" ]; then
    hyprctl dispatch focuswindow "address:$WINDOW"
    hyprctl dispatch setfloating
    hyprctl dispatch centerwindow
    hyprctl dispatch resizeactive exact 60% 60%
fi

#!/usr/bin/env bash

# read input from user
input="$1"

# pass input to displays function
if [ "$input" = "pc" ]; then
    hyprctl keyword monitor "DP-1,2560x1440@164.96Hz,0x0,1"
    hyprctl keyword monitor "DP-3,disable"
    hyprctl keyword monitor "HDMI-A-3,disable"
else
    hyprctl keyword monitor "DP-1,disable"
    hyprctl keyword monitor "DP-3,disable"
    hyprctl keyword monitor "HDMI-A-3,2560x1440@60,auto-center-left,2"
fi

# kill and respawn quickshell bar
pkill -f "quickshell/bar.qml" || true
sleep 0.5
hyprctl dispatch workspace 1
qs -p ~/dev/dotfiles/quickshell/bar.qml &

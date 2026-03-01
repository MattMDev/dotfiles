#!/usr/bin/env bash

# read input from user
input="$1"

# pass input to displays function
if [ "$input" = "pc" ]; then
    hyprctl keyword monitor "DP-1,2560x1440@164.96Hz,0x0,1"
else
    hyprctl keyword monitor "DP-1,disable"
fi

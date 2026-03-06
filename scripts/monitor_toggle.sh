#!/usr/bin/env bash

# Detect current mode: check if HDMI-A-3 is enabled
TV_ACTIVE=$(hyprctl -j monitors | jq -r '.[] | select(.name == "HDMI-A-3") | .name' 2>/dev/null)

if [ "$TV_ACTIVE" = "HDMI-A-3" ]; then
    # Currently in TV mode → switch to PC mode
    hyprctl keyword monitor "DP-1, 2560x1440@164.96Hz, 0x0, 1"
    hyprctl keyword monitor "DP-3, 1920x1080@60, auto-center-right, 1"
    hyprctl keyword monitor "HDMI-A-3, disable"
    PRIMARY="DP-1"
else
    # Currently in PC mode → switch to TV mode
    hyprctl keyword monitor "HDMI-A-3, 2560x1440@60, 0x0, 1"
    hyprctl keyword monitor "DP-1, disable"
    hyprctl keyword monitor "DP-3, disable"
    PRIMARY="HDMI-A-3"
fi

# Move workspaces 1-9 to new primary
for i in $(seq 1 9); do
    hyprctl dispatch movetoworkspace "$i:$PRIMARY"
done

# Restart quickshell bar
pkill -f "quickshell/bar.qml" || true
sleep 0.5
hyprctl dispatch workspace 1
qs -p ~/dev/dotfiles/quickshell/bar.qml &

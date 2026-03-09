#!/usr/bin/env bash

tv="HDMI-A-3"
main_screen="DP-1"
secondary_screen="DP-3"

dispatch_workspaces() {
    local monitor=$1

    mapfile -t workspaces < <(hyprctl workspaces -j | jq -r '.[].id')

    for ws in "${workspaces[@]}"; do
        if [[ "$monitor" == "$main_screen" && "$ws" == "9" ]]; then
            hyprctl dispatch moveworkspacetomonitor "9 $secondary_screen"
        else
            hyprctl dispatch moveworkspacetomonitor "$ws $monitor"
        fi
    done
}

disable_all_monitors() {
    local exclude=$1

    mapfile -t monitors < <(hyprctl -j monitors all | jq -r '.[].name')

    for monitor in "${monitors[@]}"; do
        if [[ "$monitor" != "$exclude" ]]; then
            hyprctl keyword monitor "$monitor, disable"
        fi
    done
    sleep 0.3
}

# Detect current mode: check if TV is enabled
TV_ACTIVE=$(hyprctl -j monitors | jq -r '.[] | select(.name == "'"$tv"'") | .name' 2>/dev/null)

if [ "$TV_ACTIVE" = "$tv" ]; then
    # Currently in TV mode → switch to PC mode
    disable_all_monitors "$tv"
    hyprctl keyword monitor "$main_screen, 2560x1440@164.96Hz, 0x0, 1"
    hyprctl keyword monitor "$secondary_screen, 1920x1080@60, auto-center-right, 1"
    PRIMARY="$main_screen"
else
    # Currently in PC mode → switch to TV mode
    disable_all_monitors "$main_screen"
    hyprctl keyword monitor "$tv, 2560x1440@60, 0x0, 2"
    PRIMARY="$tv"
fi

dispatch_workspaces $PRIMARY

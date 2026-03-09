#!/usr/bin/env bash

PRIMARY=$1

dispatch_workspaces() {
    local monitor=$1

    mapfile -t workspaces < <(hyprctl workspaces -j | jq -r '.[].id')

    for ws in "${workspaces[@]}"; do
        if [[ "$monitor" == "DP-1" && "$ws" == "9" ]]; then
            hyprctl dispatch moveworkspacetomonitor "9 DP-3"
        else
            hyprctl dispatch moveworkspacetomonitor "$ws $monitor"
        fi
    done
}

dispatch_workspaces $PRIMARY

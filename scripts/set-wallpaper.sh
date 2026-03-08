#!/usr/bin/env bash

set -ex

killall swaybg 2>/dev/null || true

declare -A wallpaper_map

wallpaper_map["DP-1"]="/home/matan/.config/wallpapers/2k/purple_sword.png"
wallpaper_map["DP-3"]="/home/matan/.config/wallpapers/1080/chill_house.png"
wallpaper_map["HDMI-A-3"]="/home/matan/.config/wallpapers/2k/purple_sword.png"

for monitor in $(hyprctl monitors -j | jq -r '.[].name'); do
    if [[ -n "$monitor" && -n "${wallpaper_map[$monitor]}" ]]; then
        swaybg -i "${wallpaper_map[$monitor]}" -o "$monitor" & disown
    fi
done

wait

#!/usr/bin/env bash

center_x=-650
center_y=15

echo "Cursor moved to $center_x, $center_y"

hyprctl dispatch movecursor "$center_x" "$center_y"
hyprctl dispatch movecursor "$center_x" "$center_y"

#!/bin/bash

# Install packages
# Install yay

CONF_PATH="${HOME}/.config/"
mkdir -p "${CONF_PATH}/hypr"

# copy hyperland config
cp ./hyprland.conf "${CONF_PATH}/hypr/hyprland.conf"

# apply symlinks
ln -sf ./.zshrc ~/.zshrc
ln -sf ./kitty/ "${CONF_PATH}/kitty"
ln -sf ./wofi/ "${CONF_PATH}/wofi"

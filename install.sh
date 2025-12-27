#!/bin/bash

# Install packages
# Install yay

CONF_PATH="${HOME}/.config/"
mkdir -p "${CONF_PATH}/hypr"

LOCAL_DIR=$(pwd)

# copy hyperland config
cp ./hyprland.conf "${CONF_PATH}/hypr/hyprland.conf"

# apply symlinks
ln -sf "${LOCAL_DIR}/.zshrc" ~/.zshrc
ln -sf "${LOCAL_DIR}/kitty/" "${CONF_PATH}/kitty"
ln -sf "${LOCAL_DIR}/wofi/" "${CONF_PATH}/wofi"

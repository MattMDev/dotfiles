#!/bin/bash

# Install packages
# Install yay

CONF_PATH="${HOME}/.config/"

# copy hyperland config
cp -r ./hypr/hyprland.conf "${CONF_PATH}/hypr"
exit

# apply symlinks
# ln -sf "${LOCAL_DIR}/.zshrc" ~/.zshrc
# ln -sf "${LOCAL_DIR}/kitty/" "${CONF_PATH}/kitty"
# ln -sf "${LOCAL_DIR}/wofi/" "${CONF_PATH}/wofi"
# ln -sf "${LOCAL_DIR}/wallpapers/" "${CONF_PATH}/wallpapers"
# ln -sf "${LOCAL_DIR}/dunst/" "${CONF_PATH}/dunst"
# ln -sf "${LOCAL_DIR}/wpaperd/" "${CONF_PATH}/wpaperd"

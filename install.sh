#!/bin/bash

# Install packages
# Install yay

CONF_PATH="${HOME}/.config/"
LOCAL_DIR=$(pwd)

# copy hyperland config
rm -rf "${CONF_PATH}/hypr/"
cp -r ./hypr/ "${CONF_PATH}/hypr"

# apply symlinks
ln -sf "${LOCAL_DIR}/.zshrc" ~/.zshrc
ln -sf "${LOCAL_DIR}/kitty/" "${CONF_PATH}/kitty"
ln -sf "${LOCAL_DIR}/wofi/" "${CONF_PATH}/wofi"
ln -sf "${LOCAL_DIR}/wallpapers/" "${CONF_PATH}/wallpapers"
ln -sf "${LOCAL_DIR}/dunst/" "${CONF_PATH}/dunst"
ln -sf "${LOCAL_DIR}/wpaperd/" "${CONF_PATH}/wpaperd"

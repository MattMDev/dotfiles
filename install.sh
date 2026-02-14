#!/bin/bash

# Install packages
# Install yay

CONF_PATH="${HOME}/.config/"

# copy hyperland config
cp ./hypr/* "${CONF_PATH}/hypr"

# reload hyprland if running
if pgrep -x hyprland > /dev/null; then
    hyprctl reload
fi

# apply symlinks
# LOCAL_DIR=$(pwd)
# ln -sf "${LOCAL_DIR}/.zshrc" ~/.zshrc
# ln -sf "${LOCAL_DIR}/kitty/" "${CONF_PATH}/kitty"
# ln -sf "${LOCAL_DIR}/wofi/" "${CONF_PATH}/wofi"
# ln -sf "${LOCAL_DIR}/wallpapers/" "${CONF_PATH}/wallpapers"
# ln -sf "${LOCAL_DIR}/dunst/" "${CONF_PATH}/dunst"
# ln -sf "${LOCAL_DIR}/wpaperd/" "${CONF_PATH}/wpaperd"

exit

# fix time issues
sudo timedatectl set-ntp true

# installed libraries
sudo pacman -Syu \
base-devel \
bluetui \
bluez-utils \
cliphist \
eza \
fd \
firefox \
fzf \
git \
hyprland \
jq \
kitty \
luarocks \
neovim \
nvidia-open \
nvidia-utils \
sof-firmware \
spotify-launcher \
steam \
ttf-fira-code \
ttf-jetbrains-mono-nerd \
vim \
waybar \
wiremix \
wl-clipboard \
wofi \
xf86-video-vesa \
yay \
zoxide \
zsh 


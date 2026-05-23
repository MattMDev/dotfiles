#!/bin/bash

CONF_PATH="${HOME}/.config"

# apply symlinks
LOCAL_DIR=$(pwd)
# ln -sf "$(LOCAL_DIR)/kanshi/config" "${CONF_PATH}/kanshi/config"
# ln -sf "${LOCAL_DIR}/.zshrc" ~/.zshrc
# ln -sf "${LOCAL_DIR}/hypr/" "${CONF_PATH}/hypr"
# ln -sf "${LOCAL_DIR}/kitty/" "${CONF_PATH}/kitty"
# ln -sf "${LOCAL_DIR}/wofi/" "${CONF_PATH}/wofi"
# ln -sf "${LOCAL_DIR}/wallpapers/" "${CONF_PATH}/wallpapers"
# ln -sf "${LOCAL_DIR}/dunst/" "${CONF_PATH}/dunst"
# ln -sf "${LOCAL_DIR}/wpaperd/" "${CONF_PATH}/wpaperd"
# ln -sf "${LOCAL_DIR}/qutebrowser/" "${CONF_PATH}/qutebrowser"
# ln -sf "${LOCAL_DIR}/opencode/opencode.json" "${CONF_PATH}/opencode/opencode.json"
# ln -sf "${LOCAL_DIR}/starship.toml" "${CONF_PATH}/starship.toml"
# ln -sf "${LOCAL_DIR}/spotify-launcher.conf" "${CONF_PATH}/spotify-launcher.conf"
# ln -sf "${LOCAL_DIR}/qutebrowser/greasemonkey" "${HOME}/.local/share/qutebrowser/greasemonkey"

# rm -rf "${HOME}/.local/share/qutebrowser/userscripts"
# cp -r "${LOCAL_DIR}/qutebrowser/userscripts" "${HOME}/.local/share/qutebrowser/userscripts"

exit

# fix time issues
sudo timedatectl set-ntp true

# Install nvidia drivers
sudo pacman -Sy \
    linux-headers \
    nvidia-open-dkms \
    nvidia-settings nvidia-utils lib32-nvidia-utils lib32-opencl-nvidia \
    opencl-nvidia libvdpau libxnvctrl nvidia-open

# Mango Hud
sudo pacman -Sy mangohud lib32-mangohud

# Audio
sudo pacman -Sy \
    pipewire lib32-pipewire pipewire-pulse pipewire-alsa pipewire-jack \
    pipewire-audio pipewire-v4l2 wireplumber

# Install general dependencies and programs
sudo pacman -Sy \
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
    zsh \
    qutebrowser \
    gamescope \
    python-adblock

# Enable services
systemctl --user daemon-reload
systemctl --user enable pipewire
systemctl --user enable wireplumber
systemctl enable bluetooth
systemctl enable NetworkManager
systemctl enable sddm

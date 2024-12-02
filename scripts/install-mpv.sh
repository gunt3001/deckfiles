#!/bin/bash

# Install mpv via flatpak
sudo flatpak install flathub io.mpv.Mpv --assumeyes

# Symlink configuration from deckfiles dir

# Define the source directory where your custom config files are located
SOURCE_DIR="/home/deck/Desktop/deckfiles/config/mpv"

# Define the target directories where the application expects the config files
TARGET_DIR_CONFIG="$HOME/.var/app/io.mpv.Mpv/config/mpv"
TARGET_CONFIG_FILE="$TARGET_DIR_CONFIG/mpv.conf"
TARGET_INPUT_FILE="$TARGET_DIR_CONFIG/input.conf"

# Symlink
ln -s "$SOURCE_DIR/mpv.conf" "$TARGET_CONFIG_FILE"
ln -s "$SOURCE_DIR/input.conf" "$TARGET_INPUT_FILE"
ln -s "$SOURCE_DIR/scripts" "$TARGET_DIR_CONFIG"
ln -s "$SOURCE_DIR/script-opts" "$TARGET_DIR_CONFIG"
ln -s "$SOURCE_DIR/fonts" "$TARGET_DIR_CONFIG"

echo "Symlink creation process completed."

#!/usr/bin/env bash

# Exit immediately if a command fails
set -e

# Desired boot order
BOOT_ORDER="0000,0001,0002,2001,2002,2003"

echo "Setting UEFI boot order to: $BOOT_ORDER"

# Run efibootmgr with sudo
sudo efibootmgr -o $BOOT_ORDER

echo "Boot order updated successfully."

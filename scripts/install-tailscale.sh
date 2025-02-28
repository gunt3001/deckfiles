#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Define the home directory path
HOME_DIR="$HOME"
REPO_DIR="$HOME_DIR/deck-tailscale"

# Step 1: Clone the repository into the home directory
if [ -d "$REPO_DIR" ]; then
    echo "Repository already exists. Pulling the latest changes..."
    cd "$REPO_DIR"
    git pull
else
    echo "Cloning the Tailscale repository to your home directory..."
    cd "$HOME_DIR"
    git clone https://github.com/tailscale-dev/deck-tailscale.git
    cd deck-tailscale
fi

# Step 2: Run the installation script
echo "Running the installation script..."
sudo bash tailscale.sh

# Step 3: Add the Tailscale binaries to your path
echo "Adding Tailscale binaries to the path..."
source /etc/profile.d/tailscale.sh

# Step 4: Set up Tailscale with QR code and specific options
echo "Setting up Tailscale..."
sudo tailscale up --qr --operator=deck

echo "Tailscale installation and setup are complete!"

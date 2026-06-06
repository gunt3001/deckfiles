#!/bin/bash

# --- CONFIGURATION ---
VERSION="v0.62.2"
INSTALL_DIR="$HOME/.local/bin"
# ---------------------

# Ensure the installation directory exists
mkdir -p "$INSTALL_DIR"

# Construct the download URL and asset name
TARBALL="lazygit_${VERSION#v}_linux_x86_64.tar.gz"
URL="https://github.com/jesseduffield/lazygit/releases/download/${VERSION}/${TARBALL}"

echo "Downloading Lazygit ${VERSION}..."

# Download the tarball
if curl -L "$URL" -o "$TARBALL"; then
    echo "Extracting binary to ${INSTALL_DIR}..."

    # Extract only the lazygit binary
    tar xf "$TARBALL" lazygit

    # Move it into the install directory
    mv lazygit "$INSTALL_DIR/"

    # Make it executable
    chmod +x "$INSTALL_DIR/lazygit"

    # Clean up
    rm "$TARBALL"

    echo "🎉 Lazygit ${VERSION} successfully installed to ${INSTALL_DIR}/lazygit"
else
    echo "❌ Error: Failed to download Lazygit. Please check the version or your internet connection."
    exit 1
fi

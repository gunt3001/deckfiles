#!/bin/bash

# --- CONFIGURATION ---
VERSION="v26.5.6"
ARCH="x86_64-unknown-linux-musl"
INSTALL_DIR="$HOME/.local/bin"
# ---------------------

# Ensure the installation directory exists
mkdir -p "$INSTALL_DIR"

# Construct the download URL and asset name
ZIP_NAME="yazi-${ARCH}.zip"
URL="https://github.com/sxyazi/yazi/releases/download/${VERSION}/${ZIP_NAME}"

echo "Downloading Yazi ${VERSION} for ${ARCH}..."

# Download the zip file
if curl -L "$URL" -o "$ZIP_NAME"; then
    echo "Extracting binary to ${INSTALL_DIR}..."
    
    # Extract only the binary, ignoring the internal folder structure
    unzip -j "$ZIP_NAME" "yazi-${ARCH}/yazi" -d "$INSTALL_DIR/"
    
    # Make it executable
    chmod +x "$INSTALL_DIR/yazi"
    
    # Clean up the zip file
    rm "$ZIP_NAME"
    
    echo "🎉 Yazi ${VERSION} successfully installed to ${INSTALL_DIR}/yazi"
else
    echo "❌ Error: Failed to download Yazi. Please check the version or your internet connection."
    exit 1
fi

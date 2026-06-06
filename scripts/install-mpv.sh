#!/bin/bash

set -euo pipefail

# ── Config ────────────────────────────────────────────────────────────────────
SOURCE_DIR="/home/deck/.config/mpv"
TARGET_DIR="$HOME/.var/app/io.mpv.Mpv/config/mpv"

SYMLINKS=(
    "mpv.conf"
    "input.conf"
    "scripts"
    "script-opts"
    "fonts"
)

# ── Helpers ───────────────────────────────────────────────────────────────────
info()    { echo "[INFO]  $*"; }
success() { echo "[OK]    $*"; }
warn()    { echo "[WARN]  $*" >&2; }
error()   { echo "[ERROR] $*" >&2; exit 1; }

# ── Validate source ───────────────────────────────────────────────────────────
[[ -d "$SOURCE_DIR" ]] || error "Source directory not found: $SOURCE_DIR"

# ── Install mpv via Flatpak (idempotent) ──────────────────────────────────────
info "Checking Flatpak installation of mpv..."
if flatpak info io.mpv.Mpv &>/dev/null; then
    success "mpv is already installed, skipping."
else
    info "Installing mpv via Flatpak..."
    sudo flatpak install flathub io.mpv.Mpv --assumeyes \
        || error "Flatpak install failed."
    success "mpv installed."
fi

# ── Ensure target directory exists ────────────────────────────────────────────
mkdir -p "$TARGET_DIR" || error "Failed to create target directory: $TARGET_DIR"

# ── Create symlinks (idempotent) ──────────────────────────────────────────────
info "Creating symlinks from $SOURCE_DIR → $TARGET_DIR"

for item in "${SYMLINKS[@]}"; do
    src="$SOURCE_DIR/$item"
    dst="$TARGET_DIR/$item"

    # Source must exist
    if [[ ! -e "$src" ]]; then
        warn "Source not found, skipping: $src"
        continue
    fi

    # Already a correct symlink → skip
    if [[ -L "$dst" && "$(readlink "$dst")" == "$src" ]]; then
        success "Already linked: $item"
        continue
    fi

    # Existing file/dir/wrong symlink → back it up
    if [[ -e "$dst" || -L "$dst" ]]; then
        backup="${dst}.bak.$(date +%s)"
        warn "Conflict at $dst — backing up to $backup"
        mv "$dst" "$backup" || error "Failed to back up: $dst"
    fi

    ln -s "$src" "$dst" || error "Failed to create symlink: $dst → $src"
    success "Linked: $item"
done

info "Done."

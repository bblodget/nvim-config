#!/bin/bash
# Script to install or update neovim AppImage
# Can be run from anywhere, downloads to current directory and cleans up

set -e  # Exit on error

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
INSTALL_DIR="$HOME/.local/bin"
NVIM_PATH="$INSTALL_DIR/nvim"
APPIMAGE_NAME="nvim-linux-x86_64.appimage"

echo "Neovim AppImage Installer/Updater"
echo "=================================="
echo ""

# Create install directory if it doesn't exist
mkdir -p "$INSTALL_DIR"

# Download to current script directory
cd "$SCRIPT_DIR"

# Check if neovim is already installed
if [ -f "$NVIM_PATH" ]; then
    CURRENT_VERSION=$("$NVIM_PATH" --version | head -1)
    echo "Currently installed: $CURRENT_VERSION"
    echo ""
fi

# Download latest stable neovim AppImage
echo "Downloading latest neovim stable release..."
curl -LO https://github.com/neovim/neovim/releases/latest/download/$APPIMAGE_NAME

# Make it executable
echo "Making executable..."
chmod +x $APPIMAGE_NAME

# Backup old version if it exists
if [ -f "$NVIM_PATH" ]; then
    echo "Backing up old version..."
    mv "$NVIM_PATH" "$NVIM_PATH.backup"
fi

# Move to install directory
echo "Installing to $NVIM_PATH..."
mv $APPIMAGE_NAME "$NVIM_PATH"

echo "Cleaning up..."
# Remove any leftover AppImages in this directory
rm -f "$SCRIPT_DIR"/*.appimage 2>/dev/null || true

# Verify installation
echo ""
echo "Installation complete!"
NEW_VERSION=$("$NVIM_PATH" --version | head -1)
echo "Installed: $NEW_VERSION"
echo ""
echo "Run 'nvim' to start neovim"

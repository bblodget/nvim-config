#!/usr/bin/env bash
# Sync Neovim config from ~/.config/nvim to Windows AppData location

SOURCE_DIR="$HOME/.config/nvim"
TARGET_DIR="/c/Users/$USER/AppData/Local/nvim"

echo "Syncing Neovim config..."
echo "From: $SOURCE_DIR"
echo "To:   $TARGET_DIR"

# Create target directory if it doesn't exist
mkdir -p "$TARGET_DIR"

# Copy init.lua
cp -v "$SOURCE_DIR/init.lua" "$TARGET_DIR/" 2>/dev/null

# Copy lua directory if it exists
if [ -d "$SOURCE_DIR/lua" ]; then
    cp -rv "$SOURCE_DIR/lua" "$TARGET_DIR/"
fi

# Copy any other config directories (plugin, after, ftplugin, etc.)
for dir in plugin after ftplugin; do
    if [ -d "$SOURCE_DIR/$dir" ]; then
        cp -rv "$SOURCE_DIR/$dir" "$TARGET_DIR/"
    fi
done

echo ""
echo "✓ Sync complete!"

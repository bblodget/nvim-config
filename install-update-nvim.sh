#!/bin/bash
# Script to install or update neovim, and the tree-sitter CLI it needs.
# Both are single self-contained binaries that live in ~/.local/bin.
# Can be run from anywhere, downloads to the script directory and cleans up

set -e  # Exit on error

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
INSTALL_DIR="$HOME/.local/bin"
NVIM_PATH="$INSTALL_DIR/nvim"
TS_PATH="$INSTALL_DIR/tree-sitter"

# Derived, not hardcoded: the same config is used on the x86-64 laptop and on
# arm64 machines (Raspberry Pi). Downloading the wrong one installs a binary
# that cannot execute at all.
#
# Note the two projects spell the same architecture differently -- neovim says
# "x86_64", tree-sitter says "x64" -- so each needs its own name.
case "$(uname -m)" in
    x86_64)
        APPIMAGE_NAME="nvim-linux-x86_64.appimage"
        TS_ASSET="tree-sitter-linux-x64.gz"
        ;;
    aarch64)
        APPIMAGE_NAME="nvim-linux-arm64.appimage"
        TS_ASSET="tree-sitter-linux-arm64.gz"
        ;;
    *)
        echo "No published binaries for $(uname -m)" >&2
        exit 1
        ;;
esac

echo "Neovim + tree-sitter Installer/Updater"
echo "======================================"
echo ""

# Create install directory if it doesn't exist
mkdir -p "$INSTALL_DIR"

# Download to current script directory
cd "$SCRIPT_DIR"

# ---------------------------------------------------------------- neovim ----

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

# ----------------------------------------------------------- tree-sitter ----
# Required by nvim-treesitter's "main" branch, which generates parser C from
# the grammars at install time rather than shipping it pre-generated. Neither
# Debian trixie (0.22.6) nor Pop!_OS package a new enough one, and upstream
# says explicitly not to use npm -- so take the project's own binary.

echo ""
if [ -f "$TS_PATH" ]; then
    echo "Currently installed: $("$TS_PATH" --version)"
fi

echo "Downloading latest tree-sitter CLI..."
curl -LO https://github.com/tree-sitter/tree-sitter/releases/latest/download/$TS_ASSET

echo "Extracting..."
gunzip -f "$TS_ASSET"                    # leaves tree-sitter-linux-<arch>
chmod +x "${TS_ASSET%.gz}"

if [ -f "$TS_PATH" ]; then
    echo "Backing up old version..."
    mv "$TS_PATH" "$TS_PATH.backup"
fi

echo "Installing to $TS_PATH..."
mv "${TS_ASSET%.gz}" "$TS_PATH"

# The published binary is dynamically linked against a fairly new glibc (2.39
# as of 0.26.x). Debian trixie has 2.41 and is fine; Pop!_OS 22.04 has 2.35 and
# is not. Check that it RUNS, not merely that it downloaded -- an unusable
# binary earlier in PATH than a working one is worse than no binary at all.
#
# Note this cannot be left to `set -e`: a failure inside $(...) feeding `echo`
# is not seen, which is exactly how an earlier version of this script reported
# "Installation complete!" over a broken install.
if ! "$TS_PATH" --version >/dev/null 2>&1; then
    echo "" >&2
    echo "ERROR: the tree-sitter binary will not run on this machine:" >&2
    "$TS_PATH" --version 2>&1 | sed 's/^/    /' >&2
    rm -f "$TS_PATH"
    if [ -f "$TS_PATH.backup" ]; then
        echo "Restoring previous tree-sitter..." >&2
        mv "$TS_PATH.backup" "$TS_PATH"
    fi
    echo "" >&2
    echo "Build it locally instead:  cargo install tree-sitter-cli" >&2
    echo "(neovim itself installed fine and is unaffected.)" >&2
    exit 1
fi

# ---------------------------------------------------------------------------

echo ""
echo "Cleaning up..."
rm -f "$SCRIPT_DIR"/*.appimage "$SCRIPT_DIR"/tree-sitter-linux-* 2>/dev/null || true

# Verify installation
echo ""
echo "Installation complete!"
echo "Installed: $("$NVIM_PATH" --version | head -1)"
echo "Installed: $("$TS_PATH" --version)"
echo ""
echo "Run 'nvim' to start neovim"

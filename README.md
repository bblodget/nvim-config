# Neovim Configuration

Modern Neovim configuration in Lua with Gruvbox theme and essential plugins.

## Features

- **Lua-based configuration** - Modern Neovim config using init.lua
- **Gruvbox colorscheme** - Matching terminal theme
- **lazy.nvim plugin manager** - Fast and efficient plugin management
- **Vim-compatible settings** - Ported from classic vim configuration
- **Incremental plugin setup** - Add plugins as needed

## Prerequisites

- **Neovim** 0.10.0+ (installed via AppImage on Linux x86_64, or via MSYS2 on Windows)
- **Git** - For cloning plugins
- **FiraCode Nerd Font** - For proper icon display (optional but recommended)
- **curl** - For downloading neovim updates

## Installation

### Linux x86_64

#### 1. Install Neovim (script installs for Linux x86_64)

Run the included install script:

```bash
cd ~/.config/nvim
./install-update-nvim.sh
```

This will download the latest neovim AppImage for Linux x86_64 and install it to `~/.local/bin/nvim`.

#### 2. Clone this configuration

**If you haven't installed Neovim yet**, clone this repo to `~/.config/nvim`:

```bash
git clone https://github.com/bblodget/nvim-config ~/.config/nvim
cd ~/.config/nvim
./install-update-nvim.sh
```

**If you already have the repo**, just ensure it's in the right location:

```bash
# Move/rename if needed
mv ~/nvim-config ~/.config/nvim
```

#### 3. Start Neovim

```bash
nvim
```

On first launch, lazy.nvim will automatically install all configured plugins.

### Windows (MSYS2)

#### 1. Install Neovim via MSYS2

In your MSYS2 UCRT64 shell:

```bash
pacman -S mingw-w64-ucrt-x86_64-neovim
```

#### 2. Clone this configuration

Clone to `~/.config/nvim` (for git tracking):

```bash
git clone https://github.com/bblodget/nvim-config ~/.config/nvim
```

#### 3. Sync to Windows location

On Windows, Neovim looks for config in `C:\Users\<username>\AppData\Local\nvim`. 
Use the included sync script to copy your config there:

```bash
cd ~/.config/nvim
./windows_sync.sh
```

#### 4. Start Neovim

```bash
nvim
```

On first launch, lazy.nvim will automatically install all configured plugins.

#### Windows Workflow

When working on Windows with MSYS2:

1. **Edit config** in `~/.config/nvim` (this is where git tracks changes)
2. **Run sync script** to copy to Windows location:
   ```bash
   ~/.config/nvim/windows_sync.sh
   ```
3. **Test in Neovim** - Changes will be active
4. **Commit/push** from `~/.config/nvim` as usual

The `windows_sync.sh` script copies `init.lua` and any plugin directories (`lua/`, `plugin/`, `after/`, `ftplugin/`) to the Windows AppData location while excluding git files and documentation.

## Updating Neovim

### Linux

To update to the latest neovim version, run the install script again:

```bash
cd ~/.config/nvim
./install-update-nvim.sh
```

### Windows (MSYS2)

Update via pacman:

```bash
pacman -Syu mingw-w64-ucrt-x86_64-neovim
```

## Configuration

### Basic Settings

- **Line numbers**: Enabled
- **Tabs**: 4 spaces, expanded
- **Search**: Highlighted
- **Visual indicators**: Tabs shown as `|-`, trailing spaces as `-`

### Key Mappings

- **Leader key**: `Space`
- **Window navigation**: `Ctrl-h/j/k/l` - Move between splits
- **More mappings**: Will be added as plugins are configured

### Plugins

Currently configured plugins:

1. **gruvbox.nvim** - Gruvbox colorscheme matching terminal theme
2. **nvim-tree.lua** - File explorer with icons (replaces NERDTree)
3. **gitsigns.nvim** - Git integration with visual indicators and operations
4. **telescope.nvim** - Fuzzy finder for files and text search

See [Plugin Guide](#plugin-guide) below for detailed usage.

### Plugin Management

- **View plugins**: `:Lazy` in neovim
- **Update plugins**: `:Lazy update`
- **Install new plugins**: Add to `init.lua` and restart neovim

## Customization

Edit `~/.config/nvim/init.lua` to:

- Add new plugins in the `require("lazy").setup({})` block
- Modify key mappings
- Adjust colorscheme settings
- Change basic vim options

**On Windows**: Remember to run `./windows_sync.sh` after making changes!

## Migrated from Vim

This configuration is based on a classic vim setup with:

- Pathogen → lazy.nvim (plugin manager)
- desert colorscheme → Gruvbox
- NERDTree → (planned: nvim-tree)
- Basic vim settings preserved

## File Structure

```
~/.config/nvim/
├── init.lua                    # Main configuration file
├── install-update-nvim.sh      # Neovim installer/updater script (Linux)
├── windows_sync.sh             # Sync script for Windows/MSYS2
├── .gitignore                  # Git ignore rules
└── README.md                   # This file
```

## Troubleshooting

### Plugins not loading

Run `:Lazy` and check for errors. Run `:Lazy sync` to reinstall.

### Icons not displaying

Install FiraCode Nerd Font and configure your terminal to use it.

### Neovim not found (Linux)

Ensure `~/.local/bin` is in your PATH:

```bash
echo $PATH | grep ~/.local/bin
```

If not, add to your `.bashrc`:

```bash
export PATH="$HOME/.local/bin:$PATH"
```

### Config not loading on Windows

Make sure you've run `windows_sync.sh` to copy the config to the Windows location:

```bash
~/.config/nvim/windows_sync.sh
```

Verify the sync worked:

```bash
ls /c/Users/$USER/AppData/Local/nvim/
```

### `:Lazy` command not found

Check where Neovim is looking for config:

```vim
:echo stdpath('config')
:echo stdpath('data')
```

Ensure config is in the correct location for your platform.

## License

Feel free to use and modify this configuration as you like!

## Plugin Guide

### nvim-tree (File Explorer)

A modern file tree explorer for Neovim, replacing NERDTree.

**Opening/Closing:**
- `F2` - Toggle file tree
- `Space + e` - Focus file tree

**Navigation:**
- `Enter` or `o` - Open file/folder
- `h` - Close folder
- `l` - Open folder
- `-` - Navigate to parent directory
- `Ctrl-v` - Open in vertical split
- `Ctrl-x` - Open in horizontal split
- `Ctrl-t` - Open in new tab

**File Operations:**
- `a` - Create new file/directory (add `/` at end for directory)
- `r` - Rename file/directory
- `d` - Delete file/directory
- `x` - Cut file/directory
- `c` - Copy file/directory
- `p` - Paste file/directory
- `y` - Copy filename to clipboard

**Display:**
- `H` - Toggle hidden files (dotfiles)
- `R` - Refresh tree
- `?` - Show help with all keybindings

**Tips:**
- Tree opens in current file's directory
- Icons require FiraCode Nerd Font
- Use `q` to close the tree (or `F2` to toggle)


### Gitsigns (Git Integration)

Visual git indicators and operations directly in the editor.

**Visual Indicators (Sign Column):**
- `+` - Added line
- `~` - Modified line
- `_` - Deleted line

**Navigation:**
- `]c` - Jump to next change (hunk)
- `[c` - Jump to previous change (hunk)

**Preview & Info:**
- `Space + gp` - Preview hunk (shows diff in floating window)
- `Space + gb` - Toggle git blame (shows author/commit for each line)

**Staging:**
- `Space + gs` - Stage hunk (stage this change)
- `Space + gu` - Unstage hunk

**Tips:**
- Indicators appear automatically as you edit
- Only shows changes compared to git HEAD
- Works in any git repository
- Blame info shows inline when toggled on


### Telescope (Fuzzy Finder)

Powerful fuzzy finder for files, text, and more. Essential for navigating large codebases.

**File Finding:**
- `Space + ff` - **Find Files** - Fuzzy search by filename
- `Space + fr` - **Recent Files** - Browse recently opened files
- `Space + fb` - **Find Buffers** - Switch between open files

**Text Search:**
- `Space + fg` - **Live Grep** - Search text across entire project (requires `ripgrep`)
- `Space + fh` - **Help Tags** - Search Neovim help documentation

**Using Telescope:**
1. Press a keybinding to open finder
2. Type to fuzzy search (doesn't need exact match)
3. `Ctrl-n` / `Ctrl-p` or arrow keys to navigate results
4. `Enter` to open selection
5. `Esc` to close

**In Results:**
- `Ctrl-x` - Open in horizontal split
- `Ctrl-v` - Open in vertical split
- `Ctrl-t` - Open in new tab
- `Ctrl-u` / `Ctrl-d` - Scroll preview up/down

**Tips:**
- Fuzzy matching means you can type parts of filename (e.g., "init" finds "init.lua")
- Live grep searches file contents in real-time
- For live grep to work, install `ripgrep`: `sudo apt install ripgrep`


# Neovim Configuration

Modern Neovim configuration in Lua with Gruvbox theme and essential plugins.

## Features

- **Lua-based configuration** - Modern Neovim config using init.lua
- **Gruvbox colorscheme** - Matching terminal theme
- **lazy.nvim plugin manager** - Fast and efficient plugin management
- **Vim-compatible settings** - Ported from classic vim configuration
- **Incremental plugin setup** - Add plugins as needed

## Prerequisites

- **Neovim** 0.10.0+ (installed via AppImage on Linux x86_64)
- **Git** - For cloning plugins
- **FiraCode Nerd Font** - For proper icon display (optional but recommended)
- **curl** - For downloading neovim updates

## Installation

### 1. Install Neovim (script installs for Linux x86_64)

Run the included install script:

```bash
cd ~/.config/nvim
./install-update-nvim.sh
```

This will download the latest neovim AppImage for Linux x86_64 and install it to `~/.local/bin/nvim`.

**Note:** For other platforms (macOS, Windows, ARM), see the [official Neovim installation guide](https://github.com/neovim/neovim/blob/master/INSTALL.md).

### 2. Clone this configuration

```bash
git clone <your-repo-url> ~/.config/nvim
```

### 3. Start Neovim

```bash
nvim
```

On first launch, lazy.nvim will automatically install all configured plugins.

## Updating Neovim

To update to the latest neovim version, run the install script again:

```bash
cd ~/.config/nvim
./install-update-nvim.sh
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
├── install-update-nvim.sh      # Neovim installer/updater script
├── .gitignore                  # Git ignore rules
└── README.md                   # This file
```

## Troubleshooting

### Plugins not loading

Run `:Lazy` and check for errors. Run `:Lazy sync` to reinstall.

### Icons not displaying

Install FiraCode Nerd Font and configure your terminal to use it.

### Neovim not found

Ensure `~/.local/bin` is in your PATH:

```bash
echo $PATH | grep ~/.local/bin
```

If not, add to your `.bashrc`:

```bash
export PATH="$HOME/.local/bin:$PATH"
```

## License

Feel free to use and modify this configuration as you like!

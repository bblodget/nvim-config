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
- **Terminal**: `Space+t` - Open terminal in current file's directory
  - `Esc` - Exit terminal mode (return to normal mode)
  - `Ctrl-h/j/k/l` - Navigate between terminal and editor splits

### Plugins

Currently configured plugins:

1. **gruvbox.nvim** - Gruvbox colorscheme matching terminal theme
2. **nvim-tree.lua** - File explorer with icons (replaces NERDTree)
3. **gitsigns.nvim** - Git integration with visual indicators and operations
4. **telescope.nvim** - Fuzzy finder for files and text search
5. **nvim-treesitter** - Advanced syntax highlighting and code understanding
6. **which-key.nvim** - Keybinding helper popup menu
7. **Comment.nvim** - Easy and smart code commenting
8. **toggleterm.nvim** - Terminal integration for running shell commands
9. **nvim-lspconfig + nvim-cmp** - Language Server Protocol with autocompletion

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
- `Space + e` - Focus file tree (stays in current directory)
- `Space + E` - Find current file in tree (reveals file location)

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
- Use `Space + E` after opening a file with Telescope to locate it in the tree
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
- `Space + ff` - **Find Files** - Fuzzy search by filename (excludes hidden files)
- `Space + fa` - **Find All Files** - Fuzzy search including hidden files (dotfiles)
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
- Use `Space+ff` for normal searches (cleaner results, excludes dotfiles)
- Use `Space+fa` when you need to find config files like `.bashrc`, `.gitignore`, etc.
- Live grep searches file contents in real-time
- For live grep to work, install `ripgrep`: `sudo apt install ripgrep`


### Treesitter (Advanced Syntax Highlighting)

Better syntax highlighting that understands code structure, not just patterns.

**What it does:**
- Parses code into a syntax tree (understands language structure)
- More accurate and consistent highlighting
- Enables advanced features (text objects, code navigation, etc.)
- Automatically installs parsers for configured languages

**Supported Languages:**
Pre-configured parsers for: Lua, Vim, Bash, Python, JavaScript, TypeScript, C, C++, Rust, Go, HTML, CSS, JSON, YAML, Markdown

**Commands:**
- `:TSInstall <language>` - Install parser for a specific language
- `:TSUpdate` - Update all installed parsers
- `:TSInstallInfo` - Show installed parsers and their status
- `:TSUninstall <language>` - Remove a parser

**Features:**
- **Syntax highlighting** - More accurate than regex-based highlighting
- **Smart indentation** - Understands code structure for better auto-indent
- **Auto-install** - Automatically downloads parsers for new file types

**Tips:**
- Treesitter highlighting works immediately after parser installation
- Parsers are automatically updated with `:TSUpdate`
- For large files (>100KB), treesitter disables automatically for performance


### which-key (Keybinding Helper)

Shows available keybindings in a popup menu - helps you discover and remember commands.

**How it works:**
1. Press `Space` (leader key)
2. Wait ~500ms
3. Popup appears showing available commands
4. Continue typing to execute, or explore groups

**What you'll see:**
- **e** → Explorer (nvim-tree)
- **f** → Find ▸ (opens submenu)
  - **ff** → Find Files
  - **fg** → Live Grep
  - **fb** → Find Buffers
  - **fr** → Recent Files
  - **fh** → Help Tags
- **g** → Git ▸ (opens submenu)
  - **gp** → Preview Hunk
  - **gb** → Toggle Blame
  - **gs** → Stage Hunk
  - **gu** → Unstage Hunk

**Tips:**
- Symbol `▸` means there's a submenu with more commands
- You can continue typing immediately - don't need to wait for popup
- Popup delay is 500ms (can be adjusted in config)
- Shows all registered leader key commands

**Benefits:**
- Discover keybindings as you learn
- Never forget what commands are available
- No need to memorize everything upfront


### Comment.nvim (Code Commenting)

Quick and easy code commenting that understands every language.

**Basic Usage:**
- `gcc` - Toggle comment on current line
- `gc` in visual mode - Toggle comment on selection

**With Motions:**
- `gc` + motion - Comment using motion
  - `gcap` - Comment around paragraph
  - `gc3j` - Comment current line + 3 lines down
  - `gc$` - Comment from cursor to end of line
  - `gcG` - Comment from cursor to end of file

**Visual Mode:**
1. Select lines with `V` (visual line mode) or `v` (visual mode)
2. Press `gc` - Toggle comment on selection

**Block Comments:**
- `gbc` - Toggle block comment on current line
- `gb` in visual mode - Toggle block comment on selection

**Smart Features:**
- Automatically detects comment style for each language
  - `//` for JavaScript, C, C++, Rust
  - `#` for Python, Bash, YAML
  - `--` for Lua, Haskell
  - `/* */` for CSS, C (block comments)
- Treesitter integration for context-aware commenting
- Preserves indentation

**Tips:**
- Use `.` to repeat the last comment action
- Works with counts: `5gcc` comments 5 lines
- Respects vim motions: `gcip` comments inside paragraph


### toggleterm.nvim (Terminal Integration)

Powerful terminal integration for running shell commands without leaving Neovim.

**Opening/Closing Terminal:**
- `Space + t` - Open terminal in current file's directory
- `Ctrl + \` - Toggle terminal on/off
- `Esc` - Exit terminal mode (return to normal mode)
- Type `exit` or `Ctrl-d` - Close terminal permanently

**How it works:**
1. Press `Space + t` to open terminal
2. Terminal opens in horizontal split at bottom
3. Automatically starts in current file's directory
4. Run any shell commands (git, npm, make, etc.)
5. Press `Esc` to switch back to editing
6. Press `Ctrl + \` to toggle terminal visibility

**Navigation:**
- `Ctrl-h/j/k/l` - Move between terminal and editor splits
- Terminal persists - hiding it keeps it running in background
- Re-open with `Ctrl + \` to see previous session

**Features:**
- Terminal starts in insert mode (ready to type)
- Shaded background to distinguish from editor
- Multiple terminals supported (advanced usage)
- Terminal survives hiding/showing

**Tips:**
- Use `Space + t` when you need terminal in specific directory
- Use `Ctrl + \` to quickly toggle terminal on/off
- Terminal stays running even when hidden
- Great for running tests, build commands, git operations
- Terminal opens in insert mode - just start typing commands
- Press `Esc` once to exit insert mode before closing or navigating away

**Important - Git Commits:**
- **Use `git commit -m "message"`** for commits (inline message)
- **OR use lazygit** for a full-featured git UI (recommended - see below)
- **Avoid `git commit`** without `-m` - interactive editors (nano/vi) conflict with Esc key
- This is a limitation of terminal-in-editor workflows, not a bug

**Using lazygit (Recommended for Git):**

lazygit is a terminal-based Git UI that works perfectly in toggleterm.

1. **Install lazygit** (if not already installed):
   ```bash
   LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
   curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
   tar xf lazygit.tar.gz lazygit
   install -D lazygit ~/.local/bin/lazygit
   rm lazygit lazygit.tar.gz
   ```

2. **Use in toggleterm**:
   - `Space + t` - Open terminal
   - Type `lazygit`
   - Interactive git UI opens

3. **lazygit keybindings**:
   - `?` - Show help/all keybindings
   - Arrow keys - Navigate
   - `Space` - Stage/unstage files
   - `c` - Commit (opens editor for message)
   - `P` - Push
   - `p` - Pull
   - `[` / `]` - Navigate between tabs (Files, Branches, Commits, etc.)
   - `Enter` - View details/diff
   - `q` - Quit lazygit

4. **Why lazygit is better**:
   - No Esc key conflicts
   - Visual interface for staging, committing, branching
   - See status, diffs, and history all at once
   - Write full commit messages without issues
   - Manage branches, stashes, merges easily

**Common Workflows:**
1. **Git with lazygit**: `Space + t`, type `lazygit`, stage files, commit, push, `q` to quit
2. **Quick git status**: `Space + t`, type `git status`, `Esc` to go back
3. **Git commit (inline)**: `Space + t`, type `git commit -m "fix: update config"`, `Esc` when done
4. **Run tests**: `Space + t`, run test command, watch output, `Esc` when done
5. **Build project**: `Space + t`, run build, `Ctrl + \` to hide while it runs

**What NOT to do:**
- Don't run interactive editors (nvim, vi, nano) inside the terminal
- Don't use mouse to click into terminal (use `Space + t` or `Ctrl + \` instead)
- If you accidentally get "Cannot make changes, 'modifiable' is off", press `Ctrl + \` to close and reopen


### LSP (Language Server Protocol) + Autocompletion

Intelligent code features powered by language servers - autocomplete, go-to-definition, error checking, and more.

**Languages Configured:**
- **C/C++** - clangd
- **Python** - pyright
- **JavaScript/TypeScript** - typescript-language-server

**Installation:**

Language servers must be installed separately:

```bash
# C/C++
sudo apt install clangd

# Node.js/npm (for pyright and typescript-language-server)
sudo apt install nodejs npm

# Python LSP
sudo npm install -g pyright

# JavaScript/TypeScript LSP
sudo npm install -g typescript-language-server typescript
```

**LSP Features:**

1. **Autocompletion** - Intelligent code suggestions as you type
2. **Go to Definition** - Jump to where functions/variables are defined
3. **Hover Documentation** - See documentation for functions/types
4. **Error Checking** - Real-time syntax and type errors
5. **Find References** - Find all uses of a symbol
6. **Rename** - Rename variables across entire project
7. **Code Actions** - Quick fixes and refactoring suggestions

**Keybindings:**

**Navigation:**
- `gd` - Go to definition
- `gD` - Go to declaration
- `gr` - Find references
- `gi` - Go to implementation
- `K` - Hover documentation (show function docs)

**Code Actions:**
- `Space + rn` - Rename symbol
- `Space + ca` - Code action (quick fixes)

**LSP Control:**
- `Space + lt` - Toggle LSP and completions on/off (distraction-free mode)
  - **ON**: LSP active with completions
  - **OFF**: No LSP, no completions - pure distraction-free coding

**Diagnostics (Errors/Warnings):**
- `]d` - Next diagnostic (error/warning)
- `[d` - Previous diagnostic

**Autocompletion:**
- Start typing - Autocomplete popup appears automatically
- `Ctrl + Space` - Manually trigger completion
- `Tab` - Select next item in completion menu
- `Shift + Tab` - Select previous item
- `Enter` - Confirm selection
- `Ctrl + e` - Abort/close completion menu

**Completion Sources:**
Our setup provides minimal, focused completions:
- **LSP suggestions** - Smart, context-aware completions from language servers
- **Path completions** - File paths when typing paths
- **No snippets** - Snippet support disabled for cleaner, less aggressive completions
- **No buffer words** - Doesn't suggest random words from current file

**How It Works:**

1. **Open a code file** (`.c`, `.py`, `.js`, etc.)
2. **LSP starts automatically** - Language server connects in background
3. **Start coding** - Autocomplete, errors, etc. appear as you type
4. **Use keybindings** - Navigate code with `gd`, `gr`, `K`, etc.

**Check LSP Status:**
```vim
:LspInfo
```

Shows which language servers are attached to current buffer.

**Example Workflow:**

1. **Write code** - Autocomplete suggests functions/variables
2. **See errors** - Red underlines show issues in real-time
3. **Jump to definition** - Cursor on function, press `gd`
4. **See docs** - Cursor on function, press `K`
5. **Rename** - Press `Space + rn`, type new name, Enter
6. **Quick fix** - Cursor on error, press `Space + ca` for fixes

**Tips:**
- LSP works best in git repositories (uses project root)
- For C/C++: Create `compile_commands.json` for best results
- For Python: LSP detects venvs automatically
- Autocomplete learns from your code as you type
- Use `:LspInfo` to troubleshoot if LSP not working
- Press `Space + lt` for distraction-free coding when you don't need assistance
- Use `Ctrl-o` to jump back after `gd` (go to definition)
- Use `Ctrl-i` to jump forward in your navigation history

**Troubleshooting:**

If LSP not working:
1. Check language server installed: `which clangd` / `which pyright`
2. Check LSP attached: `:LspInfo`
3. Check errors: `:messages`
4. Restart LSP: `:LspRestart`

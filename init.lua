-- Basic Neovim Configuration
-- Based on dotvim settings

-- Set leader key FIRST (before any plugins)
vim.g.mapleader = ' '           -- Set leader key (space is modern standard)

-- Basic settings from .exrc
vim.opt.number = true           -- Show line numbers
vim.opt.autoindent = true       -- Auto indent new lines
vim.opt.showmatch = true        -- Highlight matching brackets
vim.opt.tabstop = 4             -- Tabs are 4 spaces
vim.opt.shiftwidth = 4          -- Indent by 4 spaces
vim.opt.expandtab = true        -- Use spaces instead of tabs

-- Settings from vimrc.unix
vim.opt.compatible = false
vim.opt.fileformat = 'unix'
vim.opt.backup = false          -- No backup files
vim.opt.hlsearch = true         -- Highlight search results
vim.opt.visualbell = true       -- Visual bell instead of beep

-- Show tabs and trailing spaces
vim.opt.list = true
vim.opt.listchars = { tab = '|-', trail = '-' }

-- Enable syntax highlighting
vim.cmd('syntax on')

-- File type detection and plugins
vim.cmd('filetype plugin indent on')

-- Bootstrap lazy.nvim plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    print("Installing lazy.nvim plugin manager...")
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Setup plugins
require("lazy").setup({
    -- Gruvbox colorscheme (matches terminal theme)
    {
        "ellisonleao/gruvbox.nvim",
        priority = 1000,  -- Load colorscheme first
        config = function()
            require("gruvbox").setup({
                contrast = "",  -- can be "hard", "soft" or empty string
            })
            vim.cmd("colorscheme gruvbox")
        end,
    },

    -- nvim-tree: File explorer (NERDTree replacement)
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = {
            "nvim-tree/nvim-web-devicons",  -- Optional: for file icons
        },
        config = function()
            -- Disable netrw (vim's built-in file explorer)
            vim.g.loaded_netrw = 1
            vim.g.loaded_netrwPlugin = 1

            require("nvim-tree").setup({
                view = {
                    width = 30,
                },
                renderer = {
                    group_empty = true,
                },
                filters = {
                    dotfiles = false,  -- Show hidden files
                },
            })
        end,
    },

    -- Gitsigns: Git integration with sign column indicators
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require('gitsigns').setup({
                signs = {
                    add          = { text = '+' },
                    change       = { text = '~' },
                    delete       = { text = '_' },
                    topdelete    = { text = '‾' },
                    changedelete = { text = '~' },
                },
                current_line_blame = false,  -- Toggle with <leader>gb
            })
        end,
    },

    -- Telescope: Fuzzy finder for files, text, and more
    {
        "nvim-telescope/telescope.nvim",
        branch = '0.1.x',
        dependencies = {
            "nvim-lua/plenary.nvim",  -- Required dependency
        },
        config = function()
            require('telescope').setup({
                defaults = {
                    layout_config = {
                        horizontal = { width = 0.8 },
                    },
                },
            })
        end,
    },

    -- Treesitter: Better syntax highlighting and code understanding
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                -- Install parsers for these languages
                ensure_installed = {
                    "lua",
                    "vim",
                    "vimdoc",
                    "bash",
                    "python",
                    "javascript",
                    "typescript",
                    "c",
                    "cpp",
                    "rust",
                    "go",
                    "html",
                    "css",
                    "json",
                    "yaml",
                    "markdown",
                },
                -- Install parsers synchronously (only applied to `ensure_installed`)
                sync_install = false,
                -- Automatically install missing parsers when entering buffer
                auto_install = true,
                highlight = {
                    enable = true,
                    -- Disable for very large files
                    disable = function(lang, buf)
                        local max_filesize = 100 * 1024 -- 100 KB
                        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                        if ok and stats and stats.size > max_filesize then
                            return true
                        end
                    end,
                },
                indent = {
                    enable = true
                },
            })
        end,
    },

    -- which-key: Show available keybindings in a popup
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        config = function()
            local wk = require("which-key")
            wk.setup({
                delay = 500,  -- Delay before popup shows (ms)
            })

            -- Register key group descriptions
            wk.add({
                { "<leader>e", desc = "Focus Explorer" },
                { "<leader>E", desc = "Find File in Explorer" },
                { "<leader>t", desc = "Open Terminal" },
                { "<leader>f", group = "Find" },
                { "<leader>ff", desc = "Find Files" },
                { "<leader>fa", desc = "Find All (+ hidden)" },
                { "<leader>fg", desc = "Live Grep" },
                { "<leader>fb", desc = "Find Buffers" },
                { "<leader>fr", desc = "Recent Files" },
                { "<leader>fh", desc = "Help Tags" },
                { "<leader>g", group = "Git" },
                { "<leader>gp", desc = "Preview Hunk" },
                { "<leader>gb", desc = "Toggle Blame" },
                { "<leader>gs", desc = "Stage Hunk" },
                { "<leader>gu", desc = "Unstage Hunk" },
            })
        end,
    },

    -- Comment.nvim: Easy code commenting
    {
        "numToStr/Comment.nvim",
        config = function()
            require('Comment').setup()
        end,
    },

    -- toggleterm.nvim: Better terminal integration
    {
        "akinsho/toggleterm.nvim",
        version = "*",
        config = function()
            require("toggleterm").setup({
                size = 15,
                open_mapping = [[<c-\>]],
                hide_numbers = true,
                shade_terminals = true,
                start_in_insert = true,  -- Start in insert mode when terminal opens
                insert_mappings = true,   -- Allow mappings in insert mode
                terminal_mappings = true, -- Allow mappings in terminal mode (pass keys through)
                persist_size = true,
                direction = "horizontal",  -- 'vertical' | 'horizontal' | 'tab' | 'float'
                close_on_exit = true,
                shell = vim.o.shell,
            })
        end,
    },
})

-- Window navigation (Ctrl+hjkl) - from vimrc.unix
vim.keymap.set('n', '<C-J>', '<C-W><C-J>', { desc = 'Move to window below' })
vim.keymap.set('n', '<C-K>', '<C-W><C-K>', { desc = 'Move to window above' })
vim.keymap.set('n', '<C-L>', '<C-W><C-L>', { desc = 'Move to window right' })
vim.keymap.set('n', '<C-H>', '<C-W><C-H>', { desc = 'Move to window left' })

-- nvim-tree keybindings
vim.keymap.set('n', '<F2>', ':NvimTreeToggle<CR>', { desc = 'Toggle file tree', silent = true })
vim.keymap.set('n', '<leader>e', ':NvimTreeFocus<CR>', { desc = 'Focus file tree', silent = true })
vim.keymap.set('n', '<leader>E', ':NvimTreeFindFile<CR>', { desc = 'Find current file in tree', silent = true })

-- Terminal keybindings (toggleterm)
vim.keymap.set('n', '<leader>t', function()
    -- Get current file's directory
    local dir = vim.fn.expand('%:p:h')
    -- Open terminal in that directory
    local Terminal = require('toggleterm.terminal').Terminal
    local term = Terminal:new({ dir = dir })
    term:toggle()
end, { desc = 'Open terminal in current directory' })

-- Ctrl+\ also toggles terminal (built into toggleterm)
-- Esc exits terminal mode in toggleterm
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], { desc = 'Exit terminal mode' })

-- Gitsigns keybindings
vim.keymap.set('n', '<leader>gp', ':Gitsigns preview_hunk<CR>', { desc = 'Preview git hunk', silent = true })
vim.keymap.set('n', '<leader>gb', ':Gitsigns toggle_current_line_blame<CR>', { desc = 'Toggle git blame', silent = true })
vim.keymap.set('n', '<leader>gs', ':Gitsigns stage_hunk<CR>', { desc = 'Stage hunk', silent = true })
vim.keymap.set('n', '<leader>gu', ':Gitsigns undo_stage_hunk<CR>', { desc = 'Unstage hunk', silent = true })
vim.keymap.set('n', ']c', ':Gitsigns next_hunk<CR>', { desc = 'Next git hunk', silent = true })
vim.keymap.set('n', '[c', ':Gitsigns prev_hunk<CR>', { desc = 'Previous git hunk', silent = true })

-- Telescope keybindings
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find files' })
vim.keymap.set('n', '<leader>fa', function()
    builtin.find_files({ hidden = true, no_ignore = false })
end, { desc = 'Find all files (including hidden)' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Live grep (search text)' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Find buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Search help' })
vim.keymap.set('n', '<leader>fr', builtin.oldfiles, { desc = 'Recent files' })

print("Neovim config loaded! All plugins active.")

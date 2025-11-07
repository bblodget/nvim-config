-- Basic Neovim Configuration
-- Based on dotvim settings

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

-- Colorscheme
vim.cmd('colorscheme desert')

-- File type detection and plugins
vim.cmd('filetype plugin indent on')

-- Key mappings
vim.g.mapleader = ' '           -- Set leader key (space is modern standard)

-- Window navigation (Ctrl+hjkl) - from vimrc.unix
vim.keymap.set('n', '<C-J>', '<C-W><C-J>', { desc = 'Move to window below' })
vim.keymap.set('n', '<C-K>', '<C-W><C-K>', { desc = 'Move to window above' })
vim.keymap.set('n', '<C-L>', '<C-W><C-L>', { desc = 'Move to window right' })
vim.keymap.set('n', '<C-H>', '<C-W><C-H>', { desc = 'Move to window left' })

print("Neovim config loaded! Plugins not yet configured.")

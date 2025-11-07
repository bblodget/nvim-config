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
})

-- Window navigation (Ctrl+hjkl) - from vimrc.unix
vim.keymap.set('n', '<C-J>', '<C-W><C-J>', { desc = 'Move to window below' })
vim.keymap.set('n', '<C-K>', '<C-W><C-K>', { desc = 'Move to window above' })
vim.keymap.set('n', '<C-L>', '<C-W><C-L>', { desc = 'Move to window right' })
vim.keymap.set('n', '<C-H>', '<C-W><C-H>', { desc = 'Move to window left' })

print("Neovim config loaded! Gruvbox theme active.")

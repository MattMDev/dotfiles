vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Disable Built-in Plugins
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.clipboard = "unnamedplus"
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("data") .. "/undo"
vim.opt.updatetime = 100
vim.opt.timeoutlen = 1000
vim.opt.confirm = true
vim.opt.autoread = true

-- UI/Display
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 4
vim.opt.breakindent = true
vim.opt.showmode = false
vim.opt.showcmd = false
vim.opt.ruler = true
-- vim.o.winborder = 'rounded'

-- splits
vim.opt.splitbelow = true
vim.opt.splitright = true

-- search
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Indentation
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.smartindent = true

-- Files
vim.opt.fileencoding = "utf-8"
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
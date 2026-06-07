-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Only the options that differ from LazyVim defaults are set here.

local opt = vim.opt

opt.colorcolumn = "80" -- LazyVim default is "" (off)
opt.scrolloff = 8 -- LazyVim default is 4
opt.hlsearch = false -- LazyVim default is true
opt.swapfile = false
opt.undodir = vim.fn.expand "~/.vim/undodir" -- keep existing undo history location

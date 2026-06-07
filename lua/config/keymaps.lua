-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Only non-default keymaps are added here.

local map = vim.keymap.set

map("x", "p", [["_dP]], { desc = "Paste without yank" })

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.copilot_assume_mapped = true

require('config.autocmds')
require('config.keymaps')
require('config.options')
require('config.lazy')

require "nvchad.options"

local o = vim.o

-- Tab / Indentation
o.tabstop = 2
o.shiftwidth = 2
o.softtabstop = 2
o.expandtab = true
o.smartindent = true
o.wrap = false

-- Search
o.incsearch = true
o.ignorecase = true
o.smartcase = true
o.hlsearch = false

-- Appearance
o.number = true
o.relativenumber = true
o.termguicolors = true
o.colorcolumn = "80"
o.signcolumn = "yes"
o.cmdheight = 1
o.scrolloff = 8
o.completeopt = "menuone,noinsert,noselect"

-- Behaviour
o.hidden = true
o.errorbells = false
o.swapfile = false
o.backup = false
o.undodir = vim.fn.expand "~/.vim/undodir"
o.undofile = true
o.backspace = "indent,eol,start"
o.splitright = true
o.splitbelow = true
o.autochdir = false
o.modifiable = true
o.encoding = "UTF-8"
o.showmode = false

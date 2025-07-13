require "nvchad.mappings"

local map = vim.keymap.set

map("x", 'p:let @+=@0<CR>:let @"=@0<CR>', "p", { desc = "Do not override the copy content", silent = true })

map("n", "<C-h>", "<C-w>h", { desc = "Go to left window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to left window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to left window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to left window", remap = true })

map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

map("n", "<leader>ww", "<C-W>p", { desc = "Other windown", remap = true })
map("n", "<leader>wd", "<C-W>c", { desc = "Delete windown", remap = true })
map("n", "<leader>w-", "<C-W>s", { desc = "Split window below", remap = true })
map("n", "<leader>w|", "<C-W>v", { desc = "Split window right", remap = true })

map("n", "<C-h>", "<cmd>TmuxNavigateLeft<cr>", { desc = "Navigate to tmux pane on the left" })
map("n", "<C-l>", "<cmd>TmuxNavigateRight<cr>", { desc = "Navigate to tmux pane on the right" })
map("n", "<C-k>", "<cmd>TmuxNavigateUp<cr>", { desc = "Navigate to tmux pane on the top" })
map("n", "<C-j>", "<cmd>TmuxNavigateDown<cr>", { desc = "Navigate to tmux pane on the bottom" })

map("n", "<S-h>", function()
  require("nvchad.tabufline").prev()
end, { desc = "Navigate to the previous buffer" })
map("n", "<S-l>", function()
  require("nvchad.tabufline").next()
end, { desc = "Navigate to the next buffer" })
map("n", "<C-d>", function()
  require("nvchad.tabufline").close_buffer()
end, { desc = "Close the current buffer" })

map({ "n", "x" }, "j", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { desc = "Move down", expr = true })
map({ "n", "x" }, "k", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { desc = "Move up", expr = true })
map("x", "p", 'p:let @+=@0<CR>:let @"=@0<CR>', { desc = "Paste without copying replaced text", silent = true })

map({ "v" }, ">", ">gv", { desc = "Indent line to right", noremap = true, silent = true })
map({ "v" }, "<", "<gv", { desc = "Indent line to left", noremap = true, silent = true })

local diagnostic_goto = function(next, severity)
  return function()
    vim.diagnostic.jump {
      count = next and 1 or -1,
      severity = vim.diagnostic.severity[severity],
    }
  end
end

map({ "n" }, "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
map({ "n" }, "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
map({ "n" }, "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
map({ "n" }, "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
map({ "n" }, "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
map({ "n" }, "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
map({ "n" }, "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })

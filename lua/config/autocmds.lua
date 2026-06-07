-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua

-- Terraform state files as JSON (.tf/.tfvars are handled by builtin detection).
vim.filetype.add {
  extension = {
    tfstate = "json",
    ["tfstate.backup"] = "json",
  },
}

local M = {}

M.opts = {
  ensure_installed = {
    -- C/C++
    "clangd",
    "clang-format",

    -- lua
    "lua-language-server",
    "stylua",

    -- python
    "python-lsp-server",
    "ruff",

    -- web
    "html-lsp",
    "css-lsp",
    "tailwindcss-language-server",
    "eslint-lsp",

    -- js/ts
    "typescript-language-server",

    -- jvm
    "gradle-language-server",
    "jdtls",

    -- go
    "gopls",

    -- misc
    "json-lsp"
  },
}

return M

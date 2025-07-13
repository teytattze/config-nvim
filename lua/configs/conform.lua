local M = {}

M.opts = {
  formatters_by_ft = {
    c = { "clang-format" },
    cpp = { "clang-format" },
    lua = { "stylua" },
    css = { "prettier" },
    html = { "prettier" },
    json = { "prettier" },
    javascript = { "prettier" },
    javascriptreact = { "prettier" },
    typescript = { "prettier" },
    typescriptreact = { "prettier" },
    python = { "ruff_organize_imports", "ruff_format" },
    go = { "gofmt" }
  },

  format_on_save = {
    timeout_ms = 1000,
    lsp_fallback = true,
  },

  notify_on_error = true,
  notify_no_formatters = true,
}

return M

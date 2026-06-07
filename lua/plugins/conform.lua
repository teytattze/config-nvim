-- The python extra sets up the ruff LSP for formatting but does not organize
-- imports on save; route python through conform to keep the old on-save behaviour.
return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        python = {
          "ruff_organize_imports",
          "ruff_format",
        },
      },
    },
  },
}

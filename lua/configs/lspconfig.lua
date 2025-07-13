require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"
local nvlsp = require "nvchad.configs.lspconfig"

local servers = {
  -- C/C++
  clangd = {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  },

  -- vscode-langservers-extracted
  cssls = {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  },
  eslint = {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
    settings = {
      workingDirectory = {
        mode = "auto",
      },
    },
  },
  html = {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  },
  jsonls = {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  },

  -- @tailwindcss/language-server
  tailwindcss = {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
    settings = {
      tailwindCSS = {
        experimental = {
          classRegex = {
            { "cx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
            { "cn\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
            { "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
          },
        },
      },
    },
  },

  -- typescript typescript-language-server
  ts_ls = {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
    init_options = {
      preferences = {
        importModuleSpecifierPreference = "non-relative",
      },
    },
  },

  -- python python-lsp-server
  pylsp = {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
    settings = {
      pylsp = {
        plugins = {
          pyflakes = {
            enabled = false,
          },
          pycodestyle = {
            enabled = false,
          },
        },
      },
    },
  },

  -- python ruff
  ruff = {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  },

  -- go gopls
  gopls = {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  },

  -- java
  gradle_ls = {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  },
}

for lsp, opts in pairs(servers) do
  lspconfig[lsp].setup(opts)
end

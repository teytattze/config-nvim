-- Custom LSP server settings layered on top of the LazyVim language extras.
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Tailwind: custom classRegex for cx / cn / cva helpers.
        tailwindcss = {
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

        -- Pyright analysis settings (ported from NvChad lspconfig.lua).
        pyright = {
          settings = {
            pyright = { disableOrganizeImports = false },
            python = {
              analysis = {
                autoSearchPaths = true,
                diagnosticMode = "openFilesOnly",
                typeCheckingMode = "basic",
                useLibraryCodeForTypes = true,
              },
            },
          },
        },

        -- TypeScript: the lang.typescript extra uses vtsls. Port the
        -- importModuleSpecifier=non-relative preference onto it.
        vtsls = {
          settings = {
            typescript = {
              preferences = { importModuleSpecifier = "shortest" },
            },
            javascript = {
              preferences = { importModuleSpecifier = "shortest" },
            },
          },
        },
      },
    },
  },
}

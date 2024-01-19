return {
    {
        'folke/neodev.nvim',
    },

    {
        'folke/neoconf.nvim',
        cmd = 'Neoconf',
    },

    {
        'mfussenegger/nvim-jdtls',
    },

    {
        'neovim/nvim-lspconfig',
        dependencies = {
            'windwp/nvim-autopairs',
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
            'j-hui/fidget.nvim',
            'hrsh7th/nvim-cmp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-nvim-lsp',
            'scalameta/nvim-metals',
        },
        lazy = false,
        config = function()
            local cmp_nvim_lsp = require('cmp_nvim_lsp')
            local lspconfig = require('lspconfig')
            local mason = require('mason')
            local mason_lspconfig = require('mason-lspconfig')
            local metals = require('metals')
            local metals_config = require('metals').bare_config()
            local neodev = require('neodev')
            local utils_lsp = require('utils.lsp')

            mason.setup({})
            mason_lspconfig.setup({
                ensure_installed = { 'gopls', 'lua_ls', 'tsserver', 'jdtls' },
            })
            neodev.setup()

            local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
            function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
                opts = opts or {}
                opts.border = opts.border or 'rounded'
                return orig_util_open_floating_preview(contents, syntax, opts, ...)
            end

            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

            lspconfig.astro.setup({
                capabilities = capabilities,
                on_attach = utils_lsp.on_attach,
                cmd = { 'astro-ls', '--stdio' },
                filetypes = { 'astro' },
                rootdir = utils_lsp.root_pattern('package.json', 'tsconfig.json', 'jsconfig.json', '.git'),
            })

            lspconfig.gopls.setup({
                capabilities = capabilities,
                on_attach = utils_lsp.on_attach,
                cmd = { 'gopls' },
                filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
                rootdir = utils_lsp.root_pattern('.git', 'go.work', 'go.mod'),
                single_file_support = true,
            })

            lspconfig.gradle_ls.setup({
                capabilities = capabilities,
                on_attach = utils_lsp.on_attach,
                rootdir = utils_lsp.root_pattern('gradlew', '.git'),
            })

            lspconfig.marksman.setup({
                capabilities = capabilities,
                on_attach = utils_lsp.on_attach,
            })

            lspconfig.lua_ls.setup({
                capabilities = capabilities,
                on_attach = utils_lsp.on_attach,
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { 'vim' },
                        },
                        workspace = { checkThirdParty = false },
                        telemetry = { enable = false },
                    },
                },
            })

            lspconfig.tailwindcss.setup({
                capabilities = capabilities,
                on_attach = utils_lsp.on_attach,
                cmd = { 'tailwindcss-language-server', '--stdio' },
                filetypes = {
                    'astro',
                    'astro-markdown',
                    'gohtml',
                    'gohtmltmpl',
                    'html',
                    'css',
                    'postcss',
                    'javascript',
                    'javascriptreact',
                    'typescript',
                    'typescriptreact',
                    'vue',
                    'svelte',
                },
                settings = {
                    tailwindCSS = {
                        classAttributes = { 'class', 'className', 'class:list', 'classList', 'ngClass' },
                        experimental = {
                            classRegex = {
                                { 'cx\\(([^)]*)\\)', '(?:\'|"|`)([^\']*)(?:\'|"|`)' },
                                { 'cn\\(([^)]*)\\)', '(?:\'|"|`)([^\']*)(?:\'|"|`)' },
                                { 'cva\\(([^)]*)\\)', '["\'`]([^"\'`]*).*?["\'`]' },
                            },
                        },
                        lint = {
                            cssConflict = 'warning',
                            invalidApply = 'error',
                            invalidConfigPath = 'error',
                            invalidScreen = 'error',
                            invalidTailwindDirective = 'error',
                            invalidVariant = 'error',
                            recommendedVariantOrder = 'warning',
                        },
                        validate = true,
                    },
                },
            })

            lspconfig.tsserver.setup({
                capabilities = capabilities,
                on_attach = utils_lsp.on_attach,
                cmd = { 'typescript-language-server', '--stdio' },
                filetypes = {
                    'javascript',
                    'javascriptreact',
                    'javascript.jsx',
                    'typescript',
                    'typescriptreact',
                    'typescript.tsx',
                },
                init_options = {
                    preferences = {
                        importModuleSpecifierPreference = 'non-relative',
                    },
                },
                rootdir = utils_lsp.root_pattern('package.json', 'tsconfig.json', 'jsconfig.json', '.git'),
                single_file_support = true,
            })

            -- scala
            metals_config.capabilities = capabilities
            metals_config.on_attach = utils_lsp.on_attach
            metals_config.settings = {
                showImplicitArguments = true,
                excludedPackages = {},
            }
            local nvim_metals_group = vim.api.nvim_create_augroup('nvim-metals', { clear = true })
            vim.api.nvim_create_autocmd('FileType', {
                pattern = { 'scala', 'sbt', 'java' },
                callback = function()
                    metals.initialize_or_attach(metals_config)
                end,
                group = nvim_metals_group,
            })
        end,
    },
}

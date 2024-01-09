return {
    {
        'catppuccin/nvim',
        name = 'catppuccin',
        lazy = false,
        priority = 1000,
        config = function()
            require('catppuccin').setup({
                flavour = 'mocha',
                transparent_background = true,
                term_colors = true,
                integrations = {
                    cmp = true,
                    gitsigns = true,
                    indent_blankline = {
                        enabled = true,
                        scope_color = 'base',
                        colored_indent_levels = false,
                    },
                    lsp_trouble = false,
                    mason = true,
                    native_lsp = {
                        enabled = true,
                        virtual_text = {
                            errors = { 'italic' },
                            hints = { 'italic' },
                            warnings = { 'italic' },
                            information = { 'italic' },
                        },
                        underlines = {
                            errors = { 'underline' },
                            hints = { 'underline' },
                            warnings = { 'underline' },
                            information = { 'underline' },
                        },
                        inlay_hints = {
                            background = true,
                        },
                    },
                    telescope = {
                        enabled = true,
                    },
                    treesitter = true,
                    which_key = false,
                },
            })
            vim.cmd.colorscheme('catppuccin')
        end,
    },
}

return {
    {
        'akinsho/bufferline.nvim',
        dependencies = 'nvim-tree/nvim-web-devicons',
        config = function()
            local bufferline = require('bufferline')
            local const = require('utils.const')

            bufferline.setup({
                options = {
                    diagnostics = 'nvim_lsp',
                    diagnostics_indicator = function(_, _, diagnostics_dict, _)
                        local s = ' '
                        for e, n in pairs(diagnostics_dict) do
                            local sym = e == 'error' and const.error_sign_icon
                                or (e == 'warning' and const.warn_sign_icon or const.info_sign_icon)
                            s = s .. n .. sym .. ' '
                        end
                        return s
                    end,
                    offsets = {
                        {
                            filetype = 'neo-tree',
                            text = 'Neo-tree',
                            highlight = 'Directory',
                            text_align = 'left',
                        },
                    },
                },
            })

            vim.keymap.set('n', '<leader>bp', '<cmd>BufferLineTogglePin<cr>', { desc = 'Toggle pin' })
            vim.keymap.set(
                'n',
                '<leader>bP',
                '<cmd>BufferLineGroupClose ungrouped<cr>',
                { desc = 'Delete non-pinned buffers' }
            )
            vim.keymap.set('n', '<leader>bo', '<cmd>BufferLineCloseOthers<cr>', { desc = 'Delete other buffers' })
            vim.keymap.set('n', '<leader>br', '<cmd>BufferLineCloseRight<cr>', { desc = 'Delete buffers to the right' })
            vim.keymap.set('n', '<leader>bl', '<cmd>BufferLineCloseLeft<cr>', { desc = 'Delete buffers to the left' })
        end,
    },

    {
        'folke/which-key.nvim',
        lazy = false,
        config = function()
            require('which-key').register({
                ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
                ['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
                ['<leader>g'] = { name = '[G]it', _ = 'which_key_ignore' },
                ['<leader>h'] = { name = 'More git', _ = 'which_key_ignore' },
                ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
                ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
                ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
            })
        end,
    },

    {
        'nvim-lualine/lualine.nvim',
        opts = {
            options = {
                icons_enabled = true,
                theme = 'tokyonight',
                component_separators = '|',
                section_separators = '',
            },
        },
    },

    {
        'lukas-reineke/indent-blankline.nvim',
        main = 'ibl',
        config = function()
            local ibl = require('ibl')
            ibl.setup()
        end,
    },
}

return {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    config = function()
        local tokyonight = require('tokyonight')

        tokyonight.setup({
            style = 'moon',
            transparent = true,
            styles = {
                sidebars = 'transparent',
                floats = 'transparent',
            },
            lualine_bold = true,
        })

        vim.cmd.colorscheme('tokyonight')
    end,
}

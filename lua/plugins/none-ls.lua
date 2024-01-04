return {
    'nvimtools/none-ls.nvim',

    config = function()
        local null_ls = require('null-ls')

        null_ls.setup({
            sources = {
                null_ls.builtins.diagnostics.checkstyle.with({
                    extra_args = { '-c', '_config/checkstyle/google_checks.xml' },
                }),
                null_ls.builtins.diagnostics.eslint_d,
                null_ls.builtins.diagnostics.luacheck,
                null_ls.builtins.formatting.stylua,
                null_ls.builtins.formatting.prettier,
            },
        })
    end,
}

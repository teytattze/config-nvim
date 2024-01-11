return {
    'nvimtools/none-ls.nvim',
    config = function()
        local null_ls = require('null-ls')

        null_ls.setup({
            sources = {
                -- lua
                null_ls.builtins.diagnostics.luacheck,
                null_ls.builtins.formatting.stylua,

                -- jvm
                null_ls.builtins.diagnostics.checkstyle.with({
                    extra_args = {
                        '-c',
                        require('jdtls.setup').find_root({ '.git', 'mvnw', 'gradlew' })
                        .. '/_config/checkstyle/google_checks.xml',
                    },
                }),

                -- js/ts
                null_ls.builtins.diagnostics.eslint_d,
                null_ls.builtins.formatting.prettier,

                -- go
                null_ls.builtins.formatting.gofmt,
            },
        })
    end,
}

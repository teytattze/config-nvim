return {
    {
        'folke/trouble.nvim',
        dependencies = {
            'nvim-tree/nvim-web-devicons',
        },
        config = function()
            local trouble = require('trouble')

            trouble.setup({
                use_diagnostic_signs = true,
            })

            vim.keymap.set(
                'n',
                '<leader>xx',
                '<cmd>TroubleToggle document_diagnostics<cr>',
                { desc = 'Document Diagnostics (Trouble)' }
            )
            vim.keymap.set(
                'n',
                '<leader>xX',
                '<cmd>TroubleToggle workspace_diagnostics<cr>',
                { desc = 'Workspace Diagnostics (Trouble)' }
            )
            vim.keymap.set('n', '<leader>xL', '<cmd>TroubleToggle loclist<cr>', { desc = 'Location List (Trouble)' })
            vim.keymap.set('n', '<leader>xQ', '<cmd>TroubleToggle quickfix<cr>', { desc = 'Quickfix List (Trouble)' })
            vim.keymap.set('n', '[q', function()
                if require('trouble').is_open() then
                    require('trouble').previous({ skip_groups = true, jump = true })
                else
                    local ok, err = pcall(vim.cmd.cprev)
                    if not ok then
                        vim.notify(err, vim.log.levels.ERROR)
                    end
                end
            end, { desc = 'Previous trouble/quickfix item' })
            vim.keymap.set('n', ']q', function()
                if require('trouble').is_open() then
                    require('trouble').next({ skip_groups = true, jump = true })
                else
                    local ok, err = pcall(vim.cmd.cprev)
                    if not ok then
                        vim.notify(err, vim.log.levels.ERROR)
                    end
                end
            end, { desc = 'Next trouble/quickfix item' })
        end,
    },

    {
        'nvim-neo-tree/neo-tree.nvim',
        lazy = false,
        branch = 'v3.x',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-tree/nvim-web-devicons',
            'MunifTanjim/nui.nvim',
        },
        config = function()
            local const = require('utils.const')
            local neotree = require('neo-tree')

            vim.fn.sign_define('DiagnosticSignError', { text = const.error_sign_icon, texthl = 'DiagnosticSignError' })
            vim.fn.sign_define('DiagnosticSignWarn', { text = const.warn_sign_icon, texthl = 'DiagnosticSignWarn' })
            vim.fn.sign_define('DiagnosticSignInfo', { text = const.info_sign_icon, texthl = 'DiagnosticSignInfo' })
            vim.fn.sign_define('DiagnosticSignHint', { text = const.hint_sign_icon, texthl = 'DiagnosticSignHint' })

            neotree.setup({
                popup_border_style = 'rounded',
                window = {
                    position = 'float',
                    mappings = {
                        ['-'] = 'open_split',
                        ['|'] = 'open_vsplit',
                        ['<leader><tab><tab>'] = 'open_tabnew',
                    },
                },
                filesystem = {
                    filtered_items = {
                        hide_dotfiles = false,
                        hide_gitignored = false,
                        hide_by_name = {
                            '.DS_Store',
                        },
                    },
                },
            })
            vim.keymap.set('n', '\\', '<cmd>Neotree reveal<cr>', { desc = 'Reveal and focus Neotree' })
        end,
    },

    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.4',
        dependencies = {
            'nvim-lua/plenary.nvim',
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build = 'make',
                cond = function()
                    return vim.fn.executable('make') == 1
                end,
            },
        },
        config = function()
            require('telescope').setup({
                defaults = {
                    mappings = {
                        i = {
                            ['<C-u>'] = false,
                            ['<C-d>'] = false,
                        },
                    },
                },
            })

            pcall(require('telescope').load_extension, 'fzf')

            local function find_git_root()
                local current_file = vim.api.nvim_buf_get_name(0)
                local current_dir
                local cwd = vim.fn.getcwd()
                if current_file == '' then
                    current_dir = cwd
                else
                    current_dir = vim.fn.fnamemodify(current_file, ':h')
                end

                local git_root =
                    vim.fn.systemlist('git -C ' .. vim.fn.escape(current_dir, ' ') .. ' rev-parse --show-toplevel')[1]
                if vim.v.shell_error ~= 0 then
                    print('Not a git repository. Searching on current working directory')
                    return cwd
                end
                return git_root
            end

            local function live_grep_git_root()
                local git_root = find_git_root()
                if git_root then
                    require('telescope.builtin').live_grep({
                        search_dirs = { git_root },
                    })
                end
            end

            vim.api.nvim_create_user_command('LiveGrepGitRoot', live_grep_git_root, {})

            vim.keymap.set(
                'n',
                '<leader>?',
                require('telescope.builtin').oldfiles,
                { desc = '[?] Find recently opened files' }
            )
            vim.keymap.set(
                'n',
                '<leader><space>',
                require('telescope.builtin').buffers,
                { desc = '[ ] Find existing buffers' }
            )
            vim.keymap.set('n', '<leader>/', function()
                require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown({
                    winblend = 10,
                    previewer = false,
                }))
            end, { desc = '[/] Fuzzily search in current buffer' })

            vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
            vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
            vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
            vim.keymap.set(
                'n',
                '<leader>sw',
                require('telescope.builtin').grep_string,
                { desc = '[S]earch current [W]ord' }
            )
            vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
            vim.keymap.set('n', '<leader>sG', ':LiveGrepGitRoot<cr>', { desc = '[S]earch by [G]rep on Git Root' })
            vim.keymap.set(
                'n',
                '<leader>sd',
                require('telescope.builtin').diagnostics,
                { desc = '[S]earch [D]iagnostics' }
            )
            vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, { desc = '[S]earch [R]esume' })
        end,
    },

    {
        'tpope/vim-fugitive',
    },

    {
        'tpope/vim-sleuth',
    },

    {
        'christoomey/vim-tmux-navigator',
        cmd = {
            'TmuxNavigateLeft',
            'TmuxNavigateDown',
            'TmuxNavigateUp',
            'TmuxNavigateRight',
            'TmuxNavigatePrevious',
        },
        keys = {
            { '<c-h>',  '<cmd><C-U>TmuxNavigateLeft<cr>' },
            { '<c-j>',  '<cmd><C-U>TmuxNavigateDown<cr>' },
            { '<c-k>',  '<cmd><C-U>TmuxNavigateUp<cr>' },
            { '<c-l>',  '<cmd><C-U>TmuxNavigateRight<cr>' },
            { '<c-\\>', '<cmd><C-U>TmuxNavigatePrevious<cr>' },
        },
    },
}

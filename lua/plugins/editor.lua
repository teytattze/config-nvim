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
            local telescope = require('telescope')
            local telescope_actions = require('telescope.actions')
            local telescope_actions_state = require('telescope.actions.state')
            local telescope_builtin = require('telescope.builtin')

            telescope.setup({
                defaults = {
                    mappings = {
                        i = {
                            ['<C-u>'] = false,
                            ['<C-d>'] = function(prompt_bufnr)
                                local current_picker = telescope_actions_state.get_current_picker(prompt_bufnr)
                                current_picker:delete_selection(function(selection)
                                    return pcall(vim.api.nvim_buf_delete, selection.bufnr, { force = true })
                                end)
                                telescope_actions.move_selection_next(prompt_bufnr)
                            end,
                        },
                    },
                },
            })

            pcall(telescope.load_extension, 'fzf')

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
                    telescope_builtin.live_grep({
                        search_dirs = { git_root },
                    })
                end
            end

            vim.api.nvim_create_user_command('LiveGrepGitRoot', live_grep_git_root, {})
            vim.keymap.set('n', '<leader>?', telescope_builtin.oldfiles, { desc = '[?] Find recently opened files' })
            vim.keymap.set('n', '<leader><space>', telescope_builtin.buffers, { desc = '[ ] Find existing buffers' })
            vim.keymap.set('n', '<leader>/', function()
                telescope_builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown({
                    winblend = 10,
                    previewer = false,
                }))
            end, { desc = '[/] Fuzzily search in current buffer' })

            vim.keymap.set('n', '<leader>gf', telescope_builtin.git_files, { desc = 'Search [G]it [F]iles' })
            vim.keymap.set('n', '<leader>sf', telescope_builtin.find_files, { desc = '[S]earch [F]iles' })
            vim.keymap.set('n', '<leader>sh', telescope_builtin.help_tags, { desc = '[S]earch [H]elp' })
            vim.keymap.set('n', '<leader>sw', telescope_builtin.grep_string, { desc = '[S]earch current [W]ord' })
            vim.keymap.set('n', '<leader>sg', telescope_builtin.live_grep, { desc = '[S]earch by [G]rep' })
            vim.keymap.set('n', '<leader>sG', ':LiveGrepGitRoot<cr>', { desc = '[S]earch by [G]rep on Git Root' })
            vim.keymap.set('n', '<leader>sd', telescope_builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
            vim.keymap.set('n', '<leader>sr', telescope_builtin.resume, { desc = '[S]earch [R]esume' })
        end,
    },

    {
        'ThePrimeagen/harpoon',
        branch = 'harpoon2',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            local harpoon = require('harpoon')
            local telescope_actions = require('telescope.actions')
            local telescope_actions_state = require('telescope.actions.state')
            local telescope_config = require('telescope.config')
            local telescope_finders = require('telescope.finders')
            local telescope_pickers = require('telescope.pickers')

            harpoon:setup({})

            local telescope_toggle_harpoon = function(harpoon_files)
                local file_paths = {}
                for _, item in ipairs(harpoon_files.items) do
                    table.insert(file_paths, item.value)
                end

                telescope_pickers
                    .new({}, {
                        prompt_title = 'Harpoon',
                        finder = telescope_finders.new_table({
                            results = file_paths,
                        }),
                        previewer = telescope_config.values.file_previewer({}),
                        sorter = telescope_config.values.generic_sorter({}),
                        attach_mappings = function(_, map)
                            local function list_find(list, func)
                                for i, v in ipairs(list) do
                                    if func(v, i, list) then
                                        return i, v
                                    end
                                end
                            end

                            telescope_actions.select_default:replace(function(prompt_bufnr)
                                local curr_picker = telescope_actions_state.get_current_picker(prompt_bufnr)
                                local curr_entry = telescope_actions_state.get_selected_entry()
                                if not curr_entry then
                                    return
                                end
                                telescope_actions.close(prompt_bufnr)

                                local idx, _ = list_find(curr_picker.finder.results, function(v)
                                    if curr_entry.value == v.value then
                                        return true
                                    end
                                    return false
                                end)
                                harpoon:list():select(idx)
                            end)

                            map({ 'n', 'i' }, '<C-d>', function(prompt_bufnr)
                                local current_picker = telescope_actions_state.get_current_picker(prompt_bufnr)
                                current_picker:delete_selection(function(selection)
                                    harpoon:list():removeAt(selection.index)
                                end)
                            end)
                            return true
                        end,
                    })
                    :find()
            end

            vim.keymap.set('n', '<leader>hsf', function()
                telescope_toggle_harpoon(harpoon:list())
            end, { desc = '[H]arpoon [S]earch [F]iles' })

            vim.keymap.set('n', '<leader>ha', function()
                harpoon:list():append()
            end, { desc = '[H]arpoon [A]ppend File' })

            vim.keymap.set('n', '<leader>hr', function()
                harpoon:list():remove()
            end, { desc = '[H]arpoon [R]emove File' })

            vim.keymap.set('n', '<leader>hc', function()
                harpoon:list():clear()
            end, { desc = '[H]arpoon [C]lear' })

            vim.keymap.set('n', '<C-S-P>', function()
                harpoon:list():prev()
            end, { desc = 'Harpoon previous stored buffer' })

            vim.keymap.set('n', '<C-S-N>', function()
                harpoon:list():next()
            end, { desc = 'Harpoon next stored buffer' })
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

local const = require('utils.const')

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.fn.sign_define('DiagnosticSignError', { text = const.error_sign_icon, texthl = 'DiagnosticSignError' })
vim.fn.sign_define('DiagnosticSignWarn', { text = const.warn_sign_icon, texthl = 'DiagnosticSignWarn' })
vim.fn.sign_define('DiagnosticSignInfo', { text = const.info_sign_icon, texthl = 'DiagnosticSignInfo' })
vim.fn.sign_define('DiagnosticSignHint', { text = const.hint_sign_icon, texthl = 'DiagnosticSignHint' })

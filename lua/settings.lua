-- Appearance
vim.o.number = true
vim.o.relativenumber = true
vim.o.numberwidth = 3

require('NeoSolarized').setup({
    transparent = false,
})

-- Python
vim.g.python3_host_prog = '/home/pkrones/.local/share/virtualenvs/dotfiles-*/bin/python'

local function nvim_tree_attach(bufnr)
    local api = require('nvim-tree.api')
    local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    api.config.mappings.default_on_attach(bufnr)

    vim.keymap.set('n', '?', api.tree.toggle_help, opts('help'))
    vim.keymap.set('n', 's', api.node.open.vertical, opts('vsplit'))
    vim.keymap.set('n', 'i', api.node.open.horizontal, opts('hsplit'))
    vim.keymap.set('n', '<F9>', api.tree.close, opts('close'))
    vim.keymap.set('n', 'CC', api.tree.change_root_to_node, opts('change root'))
    vim.keymap.set('n', 'u', api.tree.change_root_to_parent, opts('up'))
end

-- nvim-tree
require('nvim-tree').setup({
    view = {
        width = 31,
    },
    on_attach = nvim_tree_attach,
    filters = {
        dotfiles = true,
    },
    diagnostics = {
        enable = true,
        show_on_dirs = true,
    },
    git = {
        enable = false,
    },
})

-- Spellcheck
vim.o.spelllang = 'en_us,de_de'

-- Lualine
require('lualine').setup({
    options = {
        theme = 'solarized_dark',
        component_separators = { left = '', right = '|' },
        section_separators = { left = '', right = '' },
    },
    sections = {
        lualine_c = { { 'filename', path = 1 } }
    },
    inactive_sections = {
        lualine_c = { { 'filename', path = 1 } }
    },
})

-- Usability
vim.o.splitbelow = true
vim.o.splitright = true

vim.o.foldmethod = "marker"

vim.o.hidden = true

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.cmdheight = 2

vim.o.updatetime = 300

vim.o.mouse = ''

-- Whitespace
vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.list = true
vim.o.listchars = 'tab:»·,trail:·'

local augroup = vim.api.nvim_create_augroup("initEx", { clear = true })
vim.api.nvim_create_autocmd('BufWritePre', {
    pattern = '*',
    callback = function()
        local cursor = vim.fn.getpos('.')
        vim.cmd([[s/\s\+$//ge]])
        vim.fn.setpos('.', cursor)
    end,
    group = augroup,
})
vim.cmd([[
autocmd BufReadPost * if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
]])
vim.api.nvim_create_autocmd('BufWritePre', {
    pattern = '*',
    callback = function()
        vim.lsp.buf.format({ async = false })
    end,
    group = augroup,
})

-- vim-tmux-navigator
vim.g.tmux_navigator_save_on_switch = 1

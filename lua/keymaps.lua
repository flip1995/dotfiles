local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

vim.g.mapleader = ','

-- Reload init.lua
map('n', '<F5>', ':luafile ~/.config/nvim/init.lua<CR>', opts)

-- Copy to clipboard
map('', '<leader>y', '"+y', opts)

-- nvim-tree
map('n', '<F8>', ':NvimTreeToggle<CR>', opts)
map('n', '<F9>', ':NvimTreeFindFile<CR>', opts)

-- fzf
map('n', '<leader>b', ':Buffer<CR>', opts)
map('n', '<leader>h', ':History<CR>', opts)
map('n', '<leader>r', ':Rg<CR>', opts)
map('n', '<leader>f', ":exe ':Rg' expand('<cword>')<CR>", opts)

-- Save/Close
map('n', '<leader>q', ':q<CR>', opts)
map('n', '<leader>w', ':update<CR>', opts)

-- Wrapped line navigation
map('n', 'j', 'gj', opts)
map('n', 'k', 'gk', opts)

-- LSP
map('n', 'gpd', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
map('n', 'gnd', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
map('n', 'gpe', '<cmd>lua vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })<CR>', opts)
map('n', 'gne', '<cmd>lua vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })<CR>', opts)

map('n', 'gD', "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
map('n', 'gd', ":lua require'telescope.builtin'.lsp_definitions{}<CR>", opts)
map('n', 'gi', ":lua require'telescope.builtin'.lsp_implementations{}<CR>", opts)
map('n', 'gt', ":lua require'telescope.builtin'.lsp_type_definitions{}<CR>", opts)
map('n', 'gr', ":lua require'telescope.builtin'.lsp_references{}<CR>", opts)

map('n', 'H', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
map('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)

map('n', '<leader>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
map('n', '<leader>t', ':ClangdSwitchSourceHeader<CR>', opts)

map('n', '<leader>i', ':lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<CR>', opts)

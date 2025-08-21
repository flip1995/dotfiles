local function map(mode, lhs, rhs)
    vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true })
end

vim.g.mapleader = ","

-- Reload init.lua
map("n", "<F5>", ":luafile ~/.config/nvim/init.lua<CR>")

-- Copy to clipboard
map("", "<leader>y", '"+y')

-- nvim-tree
map("n", "<F8>", ":NvimTreeToggle<CR>")
map("n", "<F9>", ":NvimTreeFindFile<CR>")

-- fzf
map("n", "<leader>b", ":Buffer<CR>")
map("n", "<leader>h", ":History<CR>")
map("n", "<leader>r", ":Rg<CR>")
map("n", "<leader>f", ":exe ':Rg' expand('<cword>')<CR>")

-- Save/Close
map("n", "<leader>q", ":q<CR>")
map("n", "<leader>w", ":update<CR>")

-- Wrapped line navigation
map("n", "j", "gj")
map("n", "k", "gk")

-- Resizing windows
map("n", "<C-right>", [[<cmd>vertical resize +5<cr>]])
map("n", "<C-left>", [[<cmd>vertical resize -5<cr>]])
map("n", "<C-down>", [[<cmd>horizontal resize +2<cr>]])
map("n", "<C-up>", [[<cmd>horizontal resize -2<cr>]])

-- LSP
map("n", "gpd", "<cmd>lua vim.diagnostic.goto_prev()<CR>")
map("n", "gnd", "<cmd>lua vim.diagnostic.goto_next()<CR>")
map("n", "gpe", "<cmd>lua vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })<CR>")
map("n", "gne", "<cmd>lua vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })<CR>")

map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>")
map("n", "gd", ":lua require'telescope.builtin'.lsp_definitions{}<CR>")
map("n", "gi", ":lua require'telescope.builtin'.lsp_implementations{}<CR>")
map("n", "gt", ":lua require'telescope.builtin'.lsp_type_definitions{}<CR>")
map("n", "gr", ":lua require'telescope.builtin'.lsp_references{}<CR>")

map("n", "H", "<cmd>lua vim.lsp.buf.hover()<CR>")
map("n", "gR", "<cmd>lua vim.lsp.buf.rename()<CR>")

map("n", "<leader>a", "<cmd>lua vim.lsp.buf.code_action()<CR>")
map("n", "<leader>t", ":ClangdSwitchSourceHeader<CR>")

map("n", "<leader>i", ":lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<CR>")

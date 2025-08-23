local function map(mode, lhs, rhs)
    vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true })
end
local builtin = require("telescope.builtin")

vim.g.mapleader = ","

-- Reload init.lua
map("n", "<F5>", ":luafile ~/.config/nvim/init.lua<CR>")

-- Copy to clipboard
map("", "<leader>y", '"+y')

-- nvim-tree
map("n", "<F8>", ":NvimTreeToggle<CR>")
map("n", "<F9>", ":NvimTreeFindFile<CR>")

-- telescope
map("n", "<leader>b", builtin.buffers)
map("n", "<leader>h", builtin.oldfiles)
map("n", "<leader>r", builtin.live_grep)
map("n", "<leader>f", builtin.grep_string)

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
map("n", "gpd", function()
    vim.diagnostic.jump { count = -1 }
end)
map("n", "gnd", function()
    vim.diagnostic.jump { count = 1 }
end)
map("n", "gpe", function()
    vim.diagnostic.jump { count = -1, severity = vim.diagnostic.severity.ERROR }
end)
map("n", "gne", function()
    vim.diagnostic.jump { count = 1, severity = vim.diagnostic.severity.ERROR }
end)

map("n", "gD", vim.lsp.buf.declaration)
map("n", "gd", builtin.lsp_definitions)
map("n", "gi", builtin.lsp_implementations)
map("n", "gt", builtin.lsp_type_definitions)
map("n", "gr", builtin.lsp_references)

map("n", "H", vim.lsp.buf.hover)
map("n", "gR", vim.lsp.buf.rename)

map("n", "<leader>a", vim.lsp.buf.code_action)
map("n", "<leader>t", ":LspClangdSwitchSourceHeader<CR>")

map("n", "<leader>i", function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end)

require("lazy").setup {
    -- tmux integration
    {
        "christoomey/vim-tmux-navigator",
        cmd = {
            "TmuxNavigateLeft",
            "TmuxNavigateDown",
            "TmuxNavigateUp",
            "TmuxNavigateRight",
        },
        keys = {
            { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
            { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
            { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
            { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
        },
    },
    -- nvim tree
    "nvim-tree/nvim-tree.lua",
    "nvim-tree/nvim-web-devicons",
    -- easy typing/editing
    "tpope/vim-surround",
    "jiangmiao/auto-pairs",
    "tomtom/tcomment_vim",
    -- fzf
    "junegunn/fzf",
    "junegunn/fzf.vim",
    -- LSP
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    "folke/neodev.nvim",
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
    },
    "stevearc/conform.nvim",
    -- Completion
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/nvim-cmp",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    -- Copilot
    "github/copilot.vim",
    -- git
    "airblade/vim-gitgutter",
    -- style
    {
        "Tsuzat/NeoSolarized.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd([[ colorscheme NeoSolarized ]])
        end,
    },
    "nvim-lualine/lualine.nvim",
}

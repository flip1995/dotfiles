require("lazy").setup({
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
    "folke/neoconf.nvim",
    "mason-org/mason.nvim",
    "mason-org/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
            enabled = function(root_dir)
                return root_dir:find("nvim") or root_dir:find("dotfiles")
            end,
        },
    },
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
    -- Debugger
    {
        "rcarriga/nvim-dap-ui",
        dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio", "stevearc/overseer.nvim" },
    },
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
}, {})

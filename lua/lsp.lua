local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup {
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert {
        ["<C-Up>"] = cmp.mapping.scroll_docs(-4),
        ["<C-Down>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm { select = true },
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    },
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
    }, {
        { name = "buffer" },
    }),
}

require("neodev").setup()

vim.lsp.inlay_hint.enable(true)

require("mason").setup {
    ui = {
        icons = {
            package_installed = "",
            package_pending = "",
            package_uninstalled = "",
        },
    },
}

local mason_lspconfig = require("mason-lspconfig")
mason_lspconfig.setup {
    ensure_installed = {
        "clangd@18.1.3",
        "lua_ls",
        "ruff@0.5.7",
        "pyright",
        "rust_analyzer",
    },
    automatic_installation = true,
}

mason_lspconfig.setup_handlers {
    function(server_name)
        require("lspconfig")[server_name].setup {}
    end,
    ["clangd"] = function()
        require("lspconfig").clangd.setup {
            cmd = { "clangd", "--background-index", "-j", "5", "--clang-tidy", "--rename-file-limit=0" },
        }
    end,
    ["rust_analyzer"] = function()
        require("lspconfig").rust_analyzer.setup {
            settings = {
                ["rust-analyzer"] = {
                    check = {
                        extraArgs = { "--target-dir", "target/rust-analyzer" },
                        features = "all",
                    },
                    rustc = {
                        source = "discover",
                    },
                },
            },
        }
    end,
    ["ruff"] = function()
        require("lspconfig").ruff.setup {
            init_options = {
                settings = {
                    configurationPreference = "filesystemFirst",
                },
            },
        }
    end,
    ["pyright"] = function()
        require("lspconfig").pyright.setup {
            settings = {
                pyright = {
                    -- Using Ruff's import organizer
                    disableOrganizeImports = true,
                },
                python = {
                    analysis = {
                        -- Ignore all files for analysis to exclusively use Ruff for linting
                        ignore = { "*" },
                    },
                },
            },
        }
    end,
    ["lua_ls"] = function()
        require("lspconfig").lua_ls.setup {
            settings = {
                Lua = {
                    format = {
                        enable = false,
                    },
                    runtime = {
                        version = "Lua 5.4",
                    },
                },
            },
        }
    end,
}

local conform = require("conform")

conform.setup {
    formatters_by_ft = {
        lua = { "stylua" },
    },
    format_on_save = {
        lsp_fallback = true,
        timeout_ms = 1000,
    },
}

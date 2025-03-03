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

require("lazydev").setup()
require("neoconf").setup()

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
        "jsonls",
    },
    automatic_installation = true,
}

local caps = require("cmp_nvim_lsp").default_capabilities()
mason_lspconfig.setup_handlers {
    function(server_name)
        require("lspconfig")[server_name].setup {
            capabilities = caps,
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
    ["lua_ls"] = function()
        require("lspconfig").lua_ls.setup {
            on_init = function(client)
                client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
                    runtime = {
                        version = "Lua 5.4",
                    },
                })
            end,
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

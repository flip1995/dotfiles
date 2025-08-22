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

require("lazydev").setup {
    library = { "nvim-dap-ui" },
}
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
        "clangd",
        "lua_ls",
        "ruff",
        "pyright",
        "rust_analyzer",
        "jsonls",
    },
}

vim.lsp.config("*", {
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
})
vim.lsp.config.ruff = {
    init_options = {
        settings = {
            configurationPreference = "filesystemFirst",
        },
    },
}
vim.lsp.config.rust_analyzer = {
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
vim.lsp.config.clangd = {
    settings = {
        clangd = {
            filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
            arguments = {
                "--background-index",
                "-j",
                "5",
                "--clang-tidy",
                "--rename-file-limit=0",
            },
        },
    },
}
vim.lsp.config.pyright = {
    settings = {
        pyright = {
            disableOrganizeImports = true,
            analysis = {
                ignore = { "*" },
            },
        },
    },
}
vim.lsp.config.lua_ls = {
    settings = {
        Lua = {
            runtime = {
                version = "Lua 5.4",
            },
            format = {
                enable = false,
            },
        },
    },
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

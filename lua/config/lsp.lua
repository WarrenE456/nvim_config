require("mason").setup()
require("mason-lspconfig").setup {
    ensure_installed = { "lua_ls", "clangd", "html", "cssls", "pyright", "rust_analyzer", "gopls"}
}

local navic = require("nvim-navic")
local navbuddy = require("nvim-navbuddy")

local on_attach = function(client, bufnr)
    if client.server_capabilities.documentSymbolProvider then
        navic.attach(client, bufnr)
        vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
        navbuddy.attach(client, bufnr)
    end
    vim.keymap.set('n', "<leader>rn", vim.lsp.buf.rename, {});
    vim.keymap.set('n', "<leader>ca", vim.lsp.buf.code_action, {});
    vim.keymap.set('n', "gd", vim.lsp.buf.definition, {});
    vim.keymap.set('n', "gi", vim.lsp.buf.implementation, {});
    vim.keymap.set('n', "K", vim.lsp.buf.hover, {});
end

local cmp = require("cmp")
cmp.setup {
    mapping = cmp.mapping.preset.insert({
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    }),
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    sources = cmp.config.sources(
    {
        { name = "nvim_lsp"},
    },
    {
        { name = "buffer" },
    }
    ),
}

local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.lsp.config("lua_ls", {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" },
            },
        }
    }
})

vim.lsp.config("clangd", {
    on_attach = on_attach,
    capabilities = capabilities,
    clangd_config = { init_options = { compilationDatabasePath = 'build/' } },
    file_types = {"c", "cpp", "cuda"},
})

-- Ocaml setup begin
-- local util = require 'lspconfig.util'
--
-- lspconfig.ocamlls.setup {
--     on_attach = on_attach,
--     capabilities = capabilities,
--   default_config = {
--     cmd = { 'ocaml-language-server', '--stdio' },
--     filetypes = { 'ocaml', 'reason' },
--     root_dir = util.root_pattern('*.opam', 'esy.json', 'package.json'),
--   },
--   docs = {
--     description = [[
-- https://github.com/ocaml-lsp/ocaml-language-server
--
-- `ocaml-language-server` can be installed via `npm`
-- ```sh
-- npm install -g ocaml-language-server
-- ```
--     ]],
--   },
-- }
-- Ocaml setup end

-- To install language server, "npm i -g vscode-langservers-extracted"
vim.lsp.config("html", {
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = { "vscode-html-language-server", "--stdio" },
    file_types = { "html", "templ" },
    init_options = {
        configurationSection = { "html", "css", "javascript" },
        embeddedLanguages = {
            css = true,
            javascript = true
        },
        provideFormatter = true
    }
})

vim.lsp.config("cssls", {
    on_attach=on_attach,
    capabilities=capabilities,
    file_types = { "css" }
})


vim.lsp.config("pyright", {
    on_attach = on_attach,
    capabilities = capabilities,
})

vim.lsp.config("rust_analyzer", {
    on_attach = function(client, bufnr)
        on_attach(client, bufnr)
        vim.lsp.inlay_hint.enable(true, {bufnr = bufnr})
    end,
    settings = {
        ["rust-analyzer"] = {
            imports = {
                granularity = {
                    group = "module",
                },
                prefix = "self",
            },
            cargo = {
                buildScripts = {
                    enable = true,
                },
            },
            procMacro = {
                enable = true
            },
        }
    }
})

vim.lsp.config("gopls", {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
      gofumpt = true,
    },
  },
})

-- Zig start
-- NOTE: Must install ZLS yourself

-- don't show parse errors in a separate window
-- vim.g.zig_fmt_parse_errors = 0
-- disable format-on-save from `ziglang/zig.vim`
-- vim.g.zig_fmt_autosave = 0

-- lspconfig.zls.setup {
--     on_attach = on_attach,
--     capabilities = capabilities,
--     cmd = { 'zls' },
-- }

-- Zig end
--
vim.lsp.enable {
    "rust_analyzer",
    "clangd",
    "luals",
    "pyright",
    "gopls",
    "cssls",
    "html"
}


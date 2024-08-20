require("mason").setup()
require("mason-lspconfig").setup {
    ensure_installed = { "lua_ls", "clangd", "html", "cssls", "pyright", "tsserver", "rust_analyzer"}
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

local lspconfig = require("lspconfig")

lspconfig.lua_ls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" },
            },
        }
    }
}

lspconfig.clangd.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    clangd_config = { init_options = { compilationDatabasePath = 'build/' } },
    file_types = {"c", "cpp", "cuda"},
}

-- To install language server, "npm i -g vscode-langservers-extracted"
lspconfig.html.setup {
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

}

lspconfig.cssls.setup {
    on_attach=on_attach,
    capabilities=capabilities,
    file_types = { "css" }
}


lspconfig.pyright.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}

lspconfig.tsserver.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = {
      'javascript',
      'javascriptreact',
      'javascript.jsx',
      'typescript',
      'typescriptreact',
      'typescript.tsx',
    },

}

lspconfig.rust_analyzer.setup({
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
-- Toggle function
local lsp_active = true;
function LSP_toggle()
    if lsp_active == true then
        vim.cmd(":w")
        vim.lsp.stop_client(vim.lsp.get_active_clients())
        lsp_active = false
    else
        vim.cmd(":w")
        vim.cmd(":e")
        lsp_active = true
    end
end

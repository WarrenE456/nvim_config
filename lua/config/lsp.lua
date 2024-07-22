require("mason").setup()
require("mason-lspconfig").setup {
    ensure_installed = { "lua_ls", "clangd", "html", "cssls", "pyright"}
}

local on_attach = function(_, _)
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

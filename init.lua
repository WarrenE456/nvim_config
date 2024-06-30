-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- Set leader
vim.g.mapleader = " "

-- Setup lazy.nvim
require("lazy").setup({
    -- Plugins go here
    spec = {
        { -- Lsp
            {"williamboman/mason.nvim"},
            {"williamboman/mason-lspconfig.nvim"},
            {"neovim/nvim-lspconfig"},
        },
        {
            'nvim-telescope/telescope.nvim', tag = '0.1.8',
                dependencies = { 'nvim-lua/plenary.nvim' }
        },

        { -- Completion and snippets
            {"hrsh7th/nvim-cmp"},
            {"hrsh7th/cmp-nvim-lsp"},
            {"L3MON4D3/LuaSnip"},
        },

        -- Color scheme
        {"rebelot/kanagawa.nvim"},

        -- GC to comment
        { 'numToStr/Comment.nvim', opts = {} },

        -- Syntax highlighting
        { "nvim-treesitter/nvim-treesitter" },
    }
})

-- LSP setup

require("mason").setup()
require("mason-lspconfig").setup {
    ensure_installed = { "lua_ls", "clangd" }
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

require ("lspconfig").lua_ls.setup {
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

require ("lspconfig").clangd.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}

require("lspconfig")

-- Treesitter setup
require("nvim-treesitter.configs").setup {
    ensure_installed = { "c", "cpp", "rust", "python", "lua", "vim", "vimdoc", "query" },
}

-- Key binds
vim.keymap.set('n', 'W', 'b', {})

-- Telescope key binds
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fn', function() builtin.find_files { cwd = vim.fn.stdpath 'config' } end, {})
vim.keymap.set('n', '<leader>/', function()
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown { winblend = 10, previewer = false, })
    end, {})

-- Vim options
-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- Set color scheme
vim.cmd.colorscheme("kanagawa-dragon")

-- Make everything transparent
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })
vim.api.nvim_set_hl(0, "NormaCursorLineNr", { bg = "none" })
vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })

-- Add line numbers
vim.cmd("set number")
vim.cmd("set rnu")

-- Remove noise
vim.cmd("let s:hidden_all = 1")
vim.cmd("set noshowmode")
vim.cmd("set noruler")
vim.cmd("set laststatus=0")
vim.cmd("set noshowcmd")

-- Set tabs
vim.cmd("set tabstop=4");
vim.cmd("set shiftwidth=4");
vim.cmd("set smarttab")
vim.cmd("set expandtab");

-- Remove tildas
vim.opt.fillchars = {eob = " "}

-- Remove error bar / sign column
vim.cmd("set signcolumn=no")

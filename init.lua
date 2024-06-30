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
        { -- Telescope
            'nvim-telescope/telescope.nvim', tag = '0.1.8',
                dependencies = { 'nvim-lua/plenary.nvim' }
        },
        { -- File tree
            "nvim-neo-tree/neo-tree.nvim",
            branch = "v3.x",
            dependencies = {
              "nvim-lua/plenary.nvim",
              "MunifTanjim/nui.nvim",
            }
        },
        { -- Completion and snippets
            {"hrsh7th/nvim-cmp"},
            {"hrsh7th/cmp-nvim-lsp"},
            {"L3MON4D3/LuaSnip"},
        },
        { -- Status line
            'nvim-lualine/lualine.nvim',
            dependencies = { 'nvim-tree/nvim-web-devicons' }
        },
        {
            'goolord/alpha-nvim',
            dependencies = { 'nvim-tree/nvim-web-devicons' },
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

-- Lua line / status line setup
require("lualine").setup {}

-- Neotree file tree setup
require("neo-tree").setup {
    close_if_last_window = true,
    window = {
        width=25,
    },
}

-- Alpha.nvim start up screen setup
require'alpha'.setup(require'alpha.themes.dashboard'.config)

-- Key binds
vim.keymap.set('n', 'W', 'b', {})

-- Navigate windows
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', {})
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', {})
vim.keymap.set('n', '<C-J>', '<C-w><C-j>', {})
vim.keymap.set('n', '<C-K>', '<C-w><C-k>', {})

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

-- Neotree keybinds
vim.keymap.set('n', '<leader>nt', function() vim.cmd("Neotree float") end, {})


-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- Vim options

-- Set color scheme
vim.cmd.colorscheme("kanagawa-dragon")

-- Make everything transparent
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
-- vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })
-- vim.api.nvim_set_hl(0, "NormaCursorLineNr", { bg = "none" })
-- vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })

-- Add line numbers
vim.cmd("set number")
vim.cmd("set rnu")

-- Remove status line
-- vim.cmd("let s:hidden_all = 1")
-- vim.cmd("set noshowmode")
-- vim.cmd("set noruler")
-- vim.cmd("set laststatus=0")
-- vim.cmd("set noshowcmd")

-- Make status line full width
vim.cmd("set laststatus=3")

-- Set tabs
vim.cmd("set tabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd("set smarttab")
vim.cmd("set expandtab")

-- Remove tildas
vim.opt.fillchars = {eob = " "}

-- Remove error bar / sign column
vim.cmd("set signcolumn=no")

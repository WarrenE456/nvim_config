return {
    { -- Lsp
        {"williamboman/mason.nvim"},
        {"williamboman/mason-lspconfig.nvim"},
        {"neovim/nvim-lspconfig"},

        { -- Completion and snippets
            {"hrsh7th/nvim-cmp"},
            {"hrsh7th/cmp-nvim-lsp"},
            {"L3MON4D3/LuaSnip"},
        },
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
    { -- Status line
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' }
    },
    { -- Start screen
        'goolord/alpha-nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
    },

    { -- Session managment
        { "rmagatti/auto-session" },
        {
        "rmagatti/session-lens",
            requires = {'rmagatti/auto-session', 'nvim-telescope/telescope.nvim'}
        }
    },

    -- Color scheme
    { "rebelot/kanagawa.nvim"},
    { "rose-pine/neovim", name="rose-pine"},

    -- GC to comment
    { 'numToStr/Comment.nvim', opts = {} },

    -- Syntax highlighting
    { "nvim-treesitter/nvim-treesitter", build=":TSUpdate"},
}

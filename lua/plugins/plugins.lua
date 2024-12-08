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
        "nvim-telescope/telescope.nvim", tag = "0.1.8",
        dependencies = { "nvim-lua/plenary.nvim" }
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
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" }
    },
    { -- Start screen
        "goolord/alpha-nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },

    { -- Session managment
        { "rmagatti/auto-session" },
        {
        "rmagatti/session-lens",
            requires = {"rmagatti/auto-session", "nvim-telescope/telescope.nvim"}
        }
    },
    {
      "jesseleite/nvim-noirbuddy",
      dependencies = {
        { "tjdevries/colorbuddy.nvim" }
      },
      lazy = false,
      priority = 1000,
      opts = {
        -- All of your `setup(opts)` will go here
      },
    },

    -- Color schemes
    { "rebelot/kanagawa.nvim"},
    { "rose-pine/neovim", name="rose-pine"},

    -- GC to comment
    { "numToStr/Comment.nvim", opts = {} },

    -- Syntax highlighting
    { "nvim-treesitter/nvim-treesitter", build=":TSUpdate"},
    {
        "kawre/leetcode.nvim",
        build = ":TSUpdate html",
        dependencies = {
            "nvim-telescope/telescope.nvim",
            "nvim-lua/plenary.nvim", -- required by telescope
            "MunifTanjim/nui.nvim",
        },
        opts = {
            lang = "cpp",
        },
    },

    -- HTML tag auto-closing
    { "windwp/nvim-ts-autotag" },

    -- Window centering
    {"shortcuts/no-neck-pain.nvim", version = "*"},

    -- Breadcrumbs
    {
        {"SmiteshP/nvim-navic"},
        {"SmiteshP/nvim-navbuddy"},
        {"MunifTanjim/nui.nvim"},
    },
    -- Zig
    { "ziglang/zig.vim" },
}

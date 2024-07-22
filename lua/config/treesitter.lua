require("nvim-treesitter.configs").setup {
    ensure_installed = { "c", "lua", "vim", "vimdoc", "rust", "python", "javascript", "html", "css" },
    sync_install = false,
    highlight = { enable = true },
    indent = { enable = true },
}

require("nvim-treesitter.configs").setup {
    ensure_installed = { "c", "cpp", "lua", "vim", "vimdoc", "rust", "python", "javascript", "html", "css", "json" },
    sync_install = false,
    highlight = { enable = true },
    indent = { enable = true },
}

vim.api.nvim_create_autocmd("ColorScheme", {
    callback = function()
        vim.api.nvim_set_hl(0, "MyIndentColor", { fg = "#302b2b", nocombine = true })

        require("ibl").setup({
            indent = {
                char = '┊',
                highlight = { "MyIndentColor" },
            },
            scope = {
                enabled = false,
            },
            exclude = {
                -- filetypes = {"cpp", "c", "rust", "haskell", "ocaml", "lua", "js", "ts", "zig", "go"},
            }
        })
    end,
})


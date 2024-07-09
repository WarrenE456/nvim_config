require("lualine").setup {
    sections = {
    lualine_a = {"mode"},
    lualine_b = {"branch", 'diagnostics'},
    lualine_c = {"filename"},
    lualine_y = {"progress"},
    lualine_x = {"filetype"},
    lualine_z = {"location"}
  },
}

-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- Make everything transparent
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })
vim.api.nvim_set_hl(0, "NormaCursorLineNr", { bg = "none" })
vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })

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

-- Remove "--INSERT--"
vim.cmd("set noshowmode")

-- Keep cursor in the roughly middle of the screen
vim.cmd("set scrolloff=10")

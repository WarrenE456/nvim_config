-- Capital W to go back a word
vim.keymap.set('n', 'W', 'b', {})

-- <C-z> to save all
vim.keymap.set('n', '<C-z>', ':wa<CR><C-z>', {})

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
vim.keymap.set('n', '<leader>fs', function() vim.cmd("SearchSession") end, {})

-- Neotree keybinds
vim.keymap.set('n', '<leader>nt', function() vim.cmd("Neotree") end, {})

-- Diagnostic float
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, {})

-- Navbuddy
vim.keymap.set('n', '<leader>nb', function() vim.cmd("Navbuddy") end, {})


-- Forward/back diagnostic
vim.keymap.set('n', '<leader>g]', function() vim.diagnostic.goto_next() end, {})
vim.keymap.set('n', '<leader>g[', function() vim.diagnostic.goto_prev() end, {})

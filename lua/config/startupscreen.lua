local alpha = require("alpha") local dashboard = require("alpha.themes.dashboard")

-- Set header
dashboard.section.header.val = {
"              .........",
"            .'------.' |",
"           | .-----. | |",
"           | |1    | | |",
"         __| |~    | | |;. _______________",
"        /  |*`-----'.|.' `;              //",
"       /   `---------' .;'              //",
" /|   /  .''''////////;'               //",
"|=|  .../ ######### /;/               //|",
"|/  /  / ######### //                //||",
"   /   `-----------'                // ||",
"  /________________________________//| ||",
"  `--------------------------------' | ||",
"   : | ||      | || |__LL__|| ||     | ||",
"   : | ||      | ||         | ||     `\"\"\'",
"   n | ||      `\"\"\'         | ||",
"   M | ||                   | ||",
"     | ||                   | ||",
"     `\"\"\'                   `\"\"\'",
}

-- Set menu
dashboard.section.buttons.val = {
    dashboard.button( "ff", "?  > Find file", ":Telescope find_files<CR>"),
    dashboard.button( "fs", "q > Find sessions", ":SearchSession <CR>"),
    dashboard.button( "r", "  > Recent"   , ":Telescope oldfiles<CR>"),
    dashboard.button( "s", "  > Config" , ":cd ~/.config/nvim | e init.lua <CR>"),
}

alpha.setup(dashboard.opts)

vim.cmd([[
    autocmd FileType alpha setlocal nofoldenable
]])


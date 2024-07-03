require("config.leader")
require("config.lazy")


-- Require all files in the config dir.
 for _, file in ipairs(vim.fn.readdir(vim.fn.stdpath('config')..'/lua/config', [[v:val =~ '\.lua$']])) do
     local module_name = file:gsub('%.lua$', '')
     if (module_name ~= 'init' and module_name ~= 'lazy' and module_name ~= 'leader') then
         require('config.'..module_name)
     end
 end

local options = require('core.tools.options')

local filetype = {}

filetype.settings_for_cpp = function()
    options:set_local_options({
        tabstop = 4,
        shiftwidth = 4,
        softtabstop = 4,
        colorcolumn = {140},
        textwidth = 140
    })
end

filetype.settings_for_python = function()
    options:set_options({
        tabstop = 4,
        shiftwidth = 4,
        softtabstop = 4,
        colorcolumn = {80},
        textwidth = 80
    })
end

filetype.settings_for_lua = function()
    options:set_options({
        tabstop = 4,
        shiftwidth = 4,
        softtabstop = 4,
        colorcolumn = {80},
        textwidth = 80
    })
end

return filetype

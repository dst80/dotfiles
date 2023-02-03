local M = {
    "navarasu/onedark.nvim",
}

function M.config()
    local onedark = require("onedark")
    onedark.setup({
        -- Main options --
        style = 'dark',
        transparent = false,
        term_colors = true,
        ending_tildes = true,
        cmp_itemkind_reverse = false,

        -- toggle theme style ---
        toggle_style_key = "<leader>ß,",
        toggle_style_list = { 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light' },

        code_style = {
            comments = 'italic',
            keywords = 'bold',
            functions = 'none',
            strings = 'none',
            variables = 'none'
        },

        lualine = {
            transparent = false,
        },
        -- onedark to nord
        colors = {
            black = "#2e3440",
            bg0 = "#2e3440",
            bg1 = "#323947",
            bg2 = "#3b4252",
            bg3 = "#4c566a",
            bg_d = "#21252b",
            bg_blue = "#5e81ac",
            bg_yellow = "#ebd09c",
            fg = "#eceff4",
            purple = "#b48ead",
            green = "#a3be8c",
            orange = "#d5937e",
            blue = "#81a1c1",
            yellow = "#ebcb8b",
            cyan = "#88c0d0",
            red = "#bf616a",
            grey = "#4c566a",
            light_grey = "#d8dee9",
            dark_cyan = "#2b6f77",
            dark_red = "#52737d",
            dark_yellow = "#a58e61",
            dark_purple = "#90728a",
            dark_blue = "#5e81ac",
            diff_add = "#31392b",
            diff_delete = "#382b2c",
            diff_change = "#1c3448",
            diff_text = "#2c5372",
        }, -- Override default colors
        highlights = {
            IncSearch = { bg = "#5e81ac" },
            --["@type"] = { fg = "#D9A0A6", fmt = "italic" },
            ["@constructor"] = { fg = "#8EA7C5", fmt = "none" },
        }, -- Override highlight groups

        diagnostics = {
            darker = false, -- darker colors for diagnostic
            undercurl = true, -- use undercurl instead of underline for diagnostics
            background = false, -- use background color for virtual text
        },
    })
    require('onedark').load()
end

return M

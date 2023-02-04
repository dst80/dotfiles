local M = {
    'rmehri01/onenord.nvim',
}

function M.config()
    local onedark = require('onenord')
    onedark.setup({
        theme = "dark",
        borders = true,
        fade_nc = false,
        styles = {
            comments = "NONE",
            strings = "NONE",
            keywords = "NONE",
            functions = "NONE",
            variables = "NONE",
            diagnostics = "underline",
        },
        disable = {
            background = false,
            cursorline = false,
            eob_lines = true,
        },
        inverse = {
            match_paren = false,
        },
        custom_highlights = {
            CursorLine = { bg = "#292f3a" },
            CursorColumn = { bg = "#292f3a" },
            ColorColumn = { bg = "#292f3a" },
            Search = { fg = "#ebcb8b", bg = "#4c566a", style = "bold" },
            IncSearch = { bg = "#4c566a", style = "bold" },
            MatchParen = { bg = "#4c566a", style = "bold" },
            WildMenu = { bg = "#4c566a", style = "bold" },
            ["@constructor"] = { fg = "#D9A0A6", fmt = "italic" },
            ["@type"] = { fg = "#8EA7C5", fmt = "none" },
        },
        custom_colors = {
            warn = "#ebcb8b"
        },
    })

    vim.cmd("colorscheme onenord")
end

return M

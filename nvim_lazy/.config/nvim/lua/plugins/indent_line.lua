local M = {
    "lukas-reineke/indent-blankline.nvim",
    lazy = true,
    event = "BufReadPost"

}

function M.config()
    require('indent_blankline').setup {
        char = '',
        show_trailing_blankline_indent = false,
    }
end

return M

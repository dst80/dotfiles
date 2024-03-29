local M = {
    "numToStr/Comment.nvim",
    lazy = true,
    event = "BufReadPost"
}

function M.config()
    require("Comment").setup({
        padding = true,
        sticky = true,
        mappings = {
            basic = true,
            extra = true,
        },
        toggler = {
            line = "gcc",
            block = "gbc",
        },
        opleader = {
            line = "gc",
            block = "gb",
        },
        extra = {
            above = "gcO",
            below = "gco",
            eol = "gcA",
        },
    })
end

return M

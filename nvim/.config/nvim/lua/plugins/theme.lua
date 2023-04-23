local M = {
    "EdenEast/nightfox.nvim",
}

function M.config()
    local nightfox = require("nightfox")
    local shade = require("nightfox.lib.shade")
    nightfox.setup({
        palettes = {
            nordfox = {
                white = shade.new("#e5e0f0", "#eceff4", "#d8dee9")

            }
        }
    })
    vim.cmd("colorscheme nordfox")
end

return M

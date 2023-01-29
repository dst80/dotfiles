local M = {
    "kylechui/nvim-surround",
    lazy = true,
    event = "BufReadPost"
}

function M.config()
    require('nvim-surround').setup({
        delimitiers = {
            aliases = {
            }
        }
    })
end

return M

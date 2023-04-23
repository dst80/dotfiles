local M = {
    "lewis6991/gitsigns.nvim",
    lazy = true,
    event = "BufReadPost",
}

function M.config()
    local has_gitsigns, gitsigns = pcall(require, "gitsigns")
    if (has_gitsigns) then
        gitsigns.setup({})
    end
end

return M

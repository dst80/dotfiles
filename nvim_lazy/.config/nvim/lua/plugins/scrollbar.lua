local M = {
    "petertriho/nvim-scrollbar",
    lazy = true,
    event = "BufReadPost",
}

function M.config()
    local success, scrollbar = pcall(require, "scrollbar")
    if success then
        scrollbar.setup({
            marks = {
                Cursor = {
                    text = "",
                }
            }
        })
    end
end

return M

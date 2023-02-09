local M = {
    "ggandor/leap.nvim",
    lazy = true,
    event = "BufReadPost",
}

function M.config()
    require("leap").add_default_mappings()
end

return M

local M = {
    "ggandor/leap.nvim",
    lazy = true,
    event = "BufReadPost",
}

function M.config()
    require("leap").add_default_mappings()

    vim.api.nvim_set_hl(0, "LeapMatch", { fg = "#2e3440", bg = "#a3be8c" })
    vim.api.nvim_set_hl(0, "LeapLabelPrimary", { fg = "#2e3440", bg = "#a3be8c" })
    vim.api.nvim_set_hl(0, "LeapLabelSecondary", { fg = "#2e3440", bg = "#ebcb8b" })
end

return M

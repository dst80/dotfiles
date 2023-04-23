local M = {
    --"github/copilot.vim"
    "zbirenbaum/copilot-cmp",
    dependencies = {
        "zbirenbaum/copilot.lua",
    },
    lazy = true,
    event = "BufReadPost",
}

function M.config()
    require("copilot").setup()
    require("copilot_cmp").setup({})
end

return M

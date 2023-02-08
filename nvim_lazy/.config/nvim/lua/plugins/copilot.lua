local M = {
    --"github/copilot.vim"
    "zbirenbaum/copilot-cmp",
    dependencies = {
        "zbirenbaum/copilot.lua",
    }
}

function M.config()
    require("copilot").setup()
    require("copilot_cmp").setup({})
end

return M

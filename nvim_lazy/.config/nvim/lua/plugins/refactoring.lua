local M = {
    "ThePrimeagen/refactoring.nvim",
    lazy = true,
    event = "BufReadPost"
}

function M.config()
    require('refactoring').setup({
        -- prompt for return type
        prompt_func_return_type = {
            go = true,
            cpp = true,
            c = true,
            h = true,
            hpp = true,
            java = true,
        },
        -- prompt for function parameters
        prompt_func_param_type = {
            go = true,
            cpp = true,
            c = true,
            h = true,
            hpp = true,
            java = true,
        },
    })

    local options = { noremap = true }

    -- load refactoring Telescope extension
    require("telescope").load_extension("refactoring")

    -- remap to open the Telescope refactoring menu in visual mode
    vim.keymap.set("v", "<leader>rr", require('telescope').extensions.refactoring.refactors, options)
end

return M
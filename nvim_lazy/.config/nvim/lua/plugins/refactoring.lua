local M = {
    "ThePrimeagen/refactoring.nvim",
    lazy = true,
    ft = { "go", "c", "cpp", "java", "typescript", "javascript", "python", "lua" },
}

M.options = {
    -- prompt for return type
    prompt_func_return_type = {
        go = true,
        java = true,
        cpp = true,
        c = true,
        h = true,
        hpp = true,
        cxx = true,
    },
    -- prompt for function parameters
    prompt_func_param_type = {
        go = true,
        java = true,
        cpp = true,
        c = true,
        h = true,
        hpp = true,
        cxx = true,
    },
}

function M.config()
    require("refactoring").setup(M.options)

    -- load refactoring Telescope extension
    require("telescope").load_extension("refactoring")

    -- remap to open the Telescope refactoring menu in visual mode
    local keymap = require("plugin_keymaps")
    keymap.map("v", keymap.list.edit_refactor, require("telescope").extensions.refactoring.refactors)
end

return M

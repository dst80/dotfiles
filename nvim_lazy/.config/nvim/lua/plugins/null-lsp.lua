local M = {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = {
        "jay-babu/mason-null-ls.nvim",
        "nvim-lua/plenary.nvim",
    },
    lazy = true,
    event = "BufReadPost",
}

function M.config()
    local null_ls = require("null-ls")
    null_ls.setup({
        debug = false,
        sources = {
            null_ls.builtins.code_actions.cspell,
            null_ls.builtins.diagnostics.cspell,
            null_ls.builtins.formatting.stylua,
            null_ls.builtins.formatting.beautysh,
            null_ls.builtins.formatting.rome,
            null_ls.builtins.formatting.prettier,
            null_ls.builtins.formatting.cmake_format,
            null_ls.builtins.formatting.clang_format,
        },
    })
    local mason_null_ls = require("mason-null-ls")
    mason_null_ls.setup({
        automatic_installation = true,
        automatic_setup = false,
    })
end

return M

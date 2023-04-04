local M = {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = {
        "jay-babu/mason-null-ls.nvim",
        "nvim-lua/plenary.nvim",
    },
    lazy = true,
    event = "BufReadPost",
}

local on_attach = function(_, bufnr)
    require("lsp_keymap").set_lsp_keymap(bufnr)
end

local diagnostics_postprocess = function(diagnostic)
    diagnostic.severity = vim.diagnostic.severity.INFO
end

function M.config()
    local null_ls = require("null-ls")
    null_ls.setup({
        debug = false,
        on_attach = on_attach,
        sources = {
            null_ls.builtins.code_actions.cspell,
            null_ls.builtins.diagnostics.cspell.with({
                diagnostics_postprocess = diagnostics_postprocess
            }),
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

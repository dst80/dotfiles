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
    require("mason-null-ls").setup({
        ensure_installed = { "stylua", "prettier", "clang_format", "beautysh" },
    })

    require("mason-null-ls").setup_handlers({
        function(source_name, methods)
            require("mason-null-ls.automatic_setup")(source_name, methods)
        end,
        stylua = function(source_name, methods)
            null_ls.register(null_ls.builtins.formatting.stylua)
        end,
        prettier = function(source_name, methods)
            null_ls.register(null_ls.builtins.formatting.prettier)
        end,
        clang_format = function(source_name, methods)
            null_ls.register(null_ls.builtins.formatting.clang_format)
        end,
        cmake_format = function(source_name, methods)
            null_ls.register(null_ls.builtins.formatting.cmake_format)
        end,
    })

    null_ls.setup({
        debug = false,
    })
end

return M

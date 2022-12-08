local M = {}

M.setup = function(_)
    local has_null_lsp, null_lsp = pcall(require, "null-lsp")
    if has_null_lsp then
        null_lsp.setup({
            null_lsp.buildins.formatting.stylua,
            null_lsp.buildins.formatting.prettierd,
            null_lsp.buildins.diagnostics.clang_format,
            null_lsp.buildins.diagnostics.cmake_format,
            null_lsp.buildins.diagnostics.cmake_lint,
            null_lsp.buildins.diagnostics.write_good,
        })
    end
end

return M

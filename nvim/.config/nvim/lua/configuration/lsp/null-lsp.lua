local M = {}

M.setup = function(_)
    local has_null_lsp, null_lsp = pcall(require, "null-lsp")
    if has_null_lsp then
        null_lsp.setup({
            null_lsp.buildin.formatting.stylua,
            null_lsp.buildin.formatting.prettierd,
        })
    end
end

return M

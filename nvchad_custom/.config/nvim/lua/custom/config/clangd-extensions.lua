local M = {}

M.filetype = {
  "c",
  "cpp",
}

M.dependencies = {
  "neovim/nvim-lspconfig",
}

function M.config(client, bufnr)
  require("clangd_extensions").setup({
    server = {
      on_attach = require("custom.config.lsp").on_attach,
      capabilities = require("custom.config.lsp").capabilities,
    },
  })
end

return M

local M = {}

M.filetype = {
  "lua",
  "sh",
  "cmake",
  "c",
  "cpp",
  "javascript",
  "typescript",
  "html",
  "yaml",
  "graphql",
  "css",
  "markdown",
}

M.dependencies = {
  "jay-babu/mason-null-ls.nvim",
}

function M.diagnostics_postprocess(diagnostic)
  diagnostic.severity = vim.diagnostic.severity.INFO
end

function M.config()
  local on_attach = require("custom.config.lsp").on_attach

  local null_ls = require("null-ls")
  null_ls.setup({
    debug = false,
    on_attach = on_attach,
    sources = {
      null_ls.builtins.formatting.stylua,
      null_ls.builtins.formatting.beautysh,
      null_ls.builtins.formatting.prettierd,
      null_ls.builtins.formatting.cmake_format,

      null_ls.builtins.code_actions.ltrs,
      null_ls.builtins.diagnostics.ltrs.with({
        diagnostics_postprocess = M.diagnostics_postprocess,
      }),
    },
  })
  local mason_null_ls = require("mason-null-ls")
  mason_null_ls.setup({
    automatic_installation = true,
    automatic_setup = true,
  })
end

return M

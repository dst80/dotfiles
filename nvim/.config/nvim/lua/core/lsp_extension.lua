require'lsp_extensions'.inlay_hints{
  highlight = "Comment",
  prefix = " > ",
  aligned = false,
  only_current_line = false,
  enabled = { "ChainingHint" }
}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  require('lsp_extensions.workspace.diagnostic').handler, {
    signs = {
      severity_limit = "Error",
    }
  }
)

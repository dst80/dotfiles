local M = {}

M.filetype = "rust"

M.dependencies = {
  "neovim/nvim-lspconfig",
  "mfussenegger/nvim-dap",
  "Saecki/crates.nvim",
  "nvim-lua/plenary.nvim",
}

function M.hover_actions()
  require("rust-tools").hover_actions.hover_actions()
end

function M.config()
  local on_attach = require("custom.config.lsp").on_attach
  local capabilities = require("custom.config.lsp").capabilities

  local rust_tools = require("rust-tools")
  rust_tools.setup({
    tools = {
      inlay_hints = {
        auto = true,
        only_current_line = true,
        show_parameter_hints = true,
      },
      hover_actions = {
        border = "none",
        auto_focus = true,
      },
    },
    server = {
      on_attach = on_attach,
      capabilities = capabilities,
      standalone = true,
    },
    dap = {
      adapter = {
        type = "executable",
        command = "lldb-vscode",
        name = "rt_lldb",
      },
    },
  })

  require("crates").setup({
    null_ls = {
      enabled = true,
      name = "crates.nvim",
    },
  })

  require("crates").show()
end

return M

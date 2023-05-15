local M = {}

function M.configure_copilot_cmp()
  require("copilot").setup()
  require("copilot_cmp").setup()
end

M.dependencies = {
  "zbirenbaum/copilot-cmp",
  config = M.configure_copilot_cmp,
  after ={"copilot.lua"},
}

M.opts = {
  sources = {
    { name = "nvim_lsp", group_index = 2 },
    { name = "copilot", group_index = 2 },
    { name = "luasnip", group_index = 2 },
    { name = "buffer", group_index = 2 },
    { name = "nvim_lua", group_index = 2 },
    { name = "path", group_index = 2 },
  },
}

return M

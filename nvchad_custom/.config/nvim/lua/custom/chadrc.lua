---@type ChadrcConfig
local M = {}

M.ui = {
  theme = "onenord",
  statusline = {
    theme = "default",
    separator_style = "block",
    overriden_modules = function()
      return {
        LSP_progress = function()
          return ""
        end,
      }
    end,
  },
}

M.plugins = "custom.plugins"

M.mappings = require("custom.mappings")

return M

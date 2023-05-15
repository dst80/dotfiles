local M = {}

function M.config()
  require("nvim-surround").setup({
    delimitiers = {
      aliases = {},
    },
  })
end

return M

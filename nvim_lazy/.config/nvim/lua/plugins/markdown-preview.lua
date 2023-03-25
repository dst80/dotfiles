local M = {
    "iamcco/markdown-preview.nvim",
    build = function() vim.fn["mkdp#util#install"]() end,
    lazy = true,
    ft = "markdown",
}

function M.config()
end

return M

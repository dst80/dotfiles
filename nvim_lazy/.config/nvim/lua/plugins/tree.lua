local M = {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    lazy = true,
    keys = {
        { "<leader>ft", "<cmd>NvimTreeToggle<cr>", desc = "[f]ile explorer [t]ree" },
    }
}

function M.config()
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
    require("nvim-tree").setup({
        renderer = {
            add_trailing = true,
            indent_width = 1,

            icons = {
                glyphs = {
                    git = {
                        untracked = "?"
                    }
                }
            }
        }
    })
end

return M

local M = {
    "Saecki/crates.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    lazy = true,
    event = { "BufRead Cargo.toml", },
}

function M.config()
    require("crates").setup({
        null_ls = {
            enabled = true,
            name = "crates.nvim",
        },
    });

    require("crates").show()
end

return M

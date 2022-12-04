require("bufferline").setup {
    options = {
        diagnostics = "nvim_lsp",
        indicator = {
            style = 'underline',
        }
    }
}

local options = { silent = true, noremap = true }
vim.keymap.set("n", "<C-b><C-n>", [[:BufferLineCycleNext<CR>]], options)
vim.keymap.set("n", "<C-b><C-p>", [[:BufferLineCyclePrev<CR>]], options)
vim.keymap.set("n", "<C-b><C-m><C-n>", [[:BufferLineMoveNext<CR>]], options)
vim.keymap.set("n", "<C-b><C-m><C-p>", [[:BufferLineMovePrev<CR>]], options)

vim.keymap.set("n", "<leader>1", [[:BufferLineGoToBuffer 1<CR>]], options)
vim.keymap.set("n", "<leader>2", [[:BufferLineGoToBuffer 2<CR>]], options)
vim.keymap.set("n", "<leader>3", [[:BufferLineGoToBuffer 3<CR>]], options)
vim.keymap.set("n", "<leader>4", [[:BufferLineGoToBuffer 4<CR>]], options)
vim.keymap.set("n", "<leader>5", [[:BufferLineGoToBuffer 5<CR>]], options)
vim.keymap.set("n", "<leader>6", [[:BufferLineGoToBuffer 6<CR>]], options)
vim.keymap.set("n", "<leader>7", [[:BufferLineGoToBuffer 7<CR>]], options)
vim.keymap.set("n", "<leader>8", [[:BufferLineGoToBuffer 8<CR>]], options)
vim.keymap.set("n", "<leader>9", [[:BufferLineGoToBuffer 9<CR>]], options)
vim.keymap.set("n", "<leader>0", [[:BufferLineGoToBuffer -1<CR>]], options)

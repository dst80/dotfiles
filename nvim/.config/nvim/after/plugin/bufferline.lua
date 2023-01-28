require("bufferline").setup {
    options = {
        diagnostics = "nvim_lsp",
        indicator = {
            style = 'underline',
        }
    }
}

local map = function(mode, keys, func, desc)
    if desc then
        desc = 'BufferLine: ' .. desc
    end
    vim.keymap.set(mode, keys, func, { noremap = true, silent = true, desc = desc })
end

local options = { silent = true, noremap = true }
map("n", "<C-b><C-n>", [[:BufferLineCycleNext<CR>]], '[b]uffer [n]ext')
map("n", "<C-b><C-p>", [[:BufferLineCyclePrev<CR>]], '[b]uffer [p]revious')
map("n", "<C-b><C-m><C-n>", [[:BufferLineMoveNext<CR>]], '[b]uffer [m]ove [n]ext')
map("n", "<C-b><C-m><C-p>", [[:BufferLineMovePrev<CR>]], '[b]uffer [m]ove [p]revious')

map("n", "<leader>1", [[:BufferLineGoToBuffer 1<CR>]], 'goto buffer [1]')
map("n", "<leader>2", [[:BufferLineGoToBuffer 2<CR>]], 'goto buffer [2]')
map("n", "<leader>3", [[:BufferLineGoToBuffer 3<CR>]], 'goto buffer [3]')
map("n", "<leader>4", [[:BufferLineGoToBuffer 4<CR>]], 'goto buffer [4]')
map("n", "<leader>5", [[:BufferLineGoToBuffer 5<CR>]], 'goto buffer [5]')
map("n", "<leader>6", [[:BufferLineGoToBuffer 6<CR>]], 'goto buffer [6]')
map("n", "<leader>7", [[:BufferLineGoToBuffer 7<CR>]], 'goto buffer [7]')
map("n", "<leader>8", [[:BufferLineGoToBuffer 8<CR>]], 'goto buffer [8]')
map("n", "<leader>9", [[:BufferLineGoToBuffer 9<CR>]], 'goto buffer [9]')
map("n", "<leader>0", [[:BufferLineGoToBuffer -1<CR>]], 'goto buffer 1[0] / last')

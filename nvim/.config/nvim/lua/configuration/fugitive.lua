local options = { noremap = true, silent = true}
vim.keymap.set("n", "<leader>gs", ":Git<CR>", options)
vim.keymap.set("n", "<leader>gc", ":G commit<CR>", options)
vim.keymap.set("n", "<leader>gd", ":G diff<CR>", options)

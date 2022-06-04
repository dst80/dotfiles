-- neo keyboard
-- window controls
vim.keymap.set("n", "<C-Left>", "<C-w>l")
vim.keymap.set("n", "<C-Right>", "<C-w>h")
vim.keymap.set("n", "<C-Down>", "<C-w>j")
vim.keymap.set("n", "<C-Up>", "<C-w>k")
-- line mover commands
vim.keymap.set("n", "<A-Down>", ":m .+1<CR>==", {silent = true})
vim.keymap.set("n", "<A-Up>", ":m .-2<CR>==", {silent = true})
vim.keymap.set("i", "<A-Down>", "<Esc>:m .+1<CR>==gi", {silent = true})
vim.keymap.set("i", "<A-Up>", "<Esc>:m .-2<CR>==gi", {silent = true})
vim.keymap.set("v", "<A-Down>", ":m '>+1<CR>gv=gv", {silent = true})
vim.keymap.set("v", "<A-Up>", ":m '<-2<CR>gv=gv", {silent = true})

-- qwerty
-- -- window controls
-- vim.keymap.set("n", "<C-l>", "<C-w>l")
-- vim.keymap.set("n", "<C-h>", "<C-w>h")
-- vim.keymap.set("n", "<C-j>", "<C-w>j")
-- vim.keymap.set("n", "<C-k>", "<C-w>k")
-- -- line mover commands
-- vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", {silent = true})
-- vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", {silent = true})
-- vim.keymap.set("n", "<A-j>", "<Esc>:m .+1<CR>==gi", {silent = true})
-- vim.keymap.set("n", "<A-k>", "<Esc>:m .-2<CR>==gi", {silent = true})
-- vim.keymap.set("n", "<A-j>", ":m '>+1<CR>gv=gv", {silent = true})
-- vim.keymap.set("n", "<A-k>", ":m '<-2<CR>gv=gv", {silent = true})


vim.keymap.set("n", "<leader>-", ":vertical resize -5<CR>", {silent = true})
vim.keymap.set("n", "<leader>+", ":vertical resize +5<CR>", {silent = true})
-- shortcuts for save and close
vim.keymap.set("n", "<C-q>", ":wq<CR>", {silent = true})
vim.keymap.set("n", "<C-s>", ":w<CR>", {silent = true})
vim.keymap.set("i", "<C-q>", "<Esc>:wq<CR>", {silent = true})
vim.keymap.set("i", "<C-s>", "<Esc>:w<CR>", {silent = true})
vim.keymap.set("n", "<leader><CR>", ":noh<CR>", {silent = true})
vim.keymap.set("n", "<leader>sv", ":luafile %<CR>", {silent = true})

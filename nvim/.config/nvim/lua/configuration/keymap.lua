local options = { silent = true, remap = true }

-- system keymap cannot be deleted, hence overriding
vim.keymap.set({ "n", "v", "i" }, "<F1>", "<nop>")
vim.keymap.set({ "n", "v", "i" }, "<C-j>", "<nop>")
vim.keymap.set({ "n", "v", "i" }, "<C-k>", "<nop>")

-- window controls
vim.keymap.set("n", "<C-Left>", "<C-w>h")
vim.keymap.set("n", "<C-Right>", "<C-w>l")
vim.keymap.set("n", "<C-Down>", "<C-w>j")
vim.keymap.set("n", "<C-Up>", "<C-w>k")

--fix weird behavior of PageUp and PageDown
vim.keymap.set("n", "<PageUp>", "<C-U>")
vim.keymap.set("n", "<PageDown>", "<C-D>")

-- line mover commands
vim.keymap.set("n", "<A-Down>", "<CMD>m .+1<CR>==", options)
vim.keymap.set("n", "<A-Up>", "<CMD>m .-2<CR>==", options)
vim.keymap.set("i", "<A-Down>", "<ESC><CMD>m .+1<CR>==gi", options)
vim.keymap.set("i", "<A-Up>", "<ESC><CMD>m .-2<CR>==gi", options)
vim.keymap.set("v", "<A-Down>", ":m '>+1<CR>gv=gv", options)
vim.keymap.set("v", "<A-Up>", ":m '<-2<CR>gv=gv", options)

-- shortcuts for open, save and close
vim.keymap.set("n", "<leader>o", [[:e <C-R>=expand("%:p:h") . "/"<CR>]], { remap = false })
vim.keymap.set("n", "<C-n>", [[:e <C-R>=expand("%:p:h") . "/"<CR>]], { remap = false })
vim.keymap.set("n", "<C-s>", ":w<CR>", options)
vim.keymap.set("i", "<C-s>", "<Esc>:w<CR>", options)
vim.keymap.set("n", "<C-q>", ":wq<CR>", options)
vim.keymap.set("i", "<C-q>", "<Esc>:wq<CR>", options)
vim.keymap.set("n", "<leader><CR>", ":noh<CR>", options)
vim.keymap.set("n", "<leader><leader>x", ":luafile %<CR>", options)

-- simpler copy and paste commands
vim.keymap.set({ "n", "v" }, "<leader>p", [["+p]], options)
vim.keymap.set({ "n", "v" }, "<leader>P", [["+P]], options)
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], options)
vim.keymap.set({ "n", "v" }, "<leader>Y", [["+y$]], options)

-- addtional useful commands
vim.keymap.set("n", "<leader>e", [[/_<CR>l:noh<CR>:let @/=""<CR>]], options)
vim.keymap.set("n", "<leader>m", "ct_", options)
vim.keymap.set("n", "<leader>w", [[/[A-Z]<CR>:noh<CR>:let @/=""<CR>]], options)

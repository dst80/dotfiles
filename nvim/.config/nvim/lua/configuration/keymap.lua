local options = { silent = true, noremap = true }

-- system keymap cannot be deleted, hence overriding
vim.keymap.set({ "n", "v", "i" }, "<F1>", "<nop>", options)
vim.keymap.set({ "n", "v", "i" }, "<C-j>", "<nop>", options)
vim.keymap.set({ "n", "v", "i" }, "<C-k>", "<nop>", options)

-- window controls
vim.keymap.set("n", "<C-Left>", "<C-w>h", options)
vim.keymap.set("n", "<C-Right>", "<C-w>l", options)
vim.keymap.set("n", "<C-Down>", "<C-w>j", options)
vim.keymap.set("n", "<C-Up>", "<C-w>k", options)

--fix weird behavior of PageUp and PageDown
vim.keymap.set("n", "<PageUp>", "<C-u>zz", options)
vim.keymap.set("n", "<PageDown>", "<C-d>zz", options)

-- keeps cursor on the front
vim.keymap.set("n", "J", "mzJ`z", options)

-- move half page to center of the screen
vim.keymap.set("n", "<C-d>", "<C-d>zz", options)
vim.keymap.set("n", "<C-u>", "<C-u>zz", options)

-- centers cursor on search
vim.keymap.set("n", "n", "nzzzv", options)
vim.keymap.set("n", "N", "Nzzzv", options)

-- line mover commands
vim.keymap.set("n", "<A-Down>", "<CMD>m .+1<CR>==", options)
vim.keymap.set("n", "<A-Up>", "<CMD>m .-2<CR>==", options)
vim.keymap.set("i", "<A-Down>", "<ESC><CMD>m .+1<CR>==gi", options)
vim.keymap.set("i", "<A-Up>", "<ESC><CMD>m .-2<CR>==gi", options)
vim.keymap.set("v", "<A-Down>", ":m '>+1<CR>gv=gv", options)
vim.keymap.set("v", "<A-Up>", ":m '<-2<CR>gv=gv", options)

-- shortcuts for open, save and close
vim.keymap.set("n", "<leader>o", [[:e <C-R>=expand("%:p:h") . "/"<CR>]], { noremap = false })
vim.keymap.set("n", "<C-n>", [[:e <C-R>=expand("%:p:h") . "/"<CR>]], { noremap = false })
vim.keymap.set("n", "<C-s>", ":w<CR>", options)
vim.keymap.set("i", "<C-s>", "<Esc>:w<CR>", options)
vim.keymap.set("n", "<C-q>", ":wq<CR>", options)
vim.keymap.set("i", "<C-q>", "<Esc>:wq<CR>", options)
vim.keymap.set("i", "<C-h>", "<Esc>:wq<CR>", options)
vim.keymap.set("n", "<leader><leader>x", ":luafile %<CR>", options)

-- simpler copy and paste commands
vim.keymap.set("v", "p", "\"_dP", options)
vim.keymap.set({ "n", "v" }, "<leader>p", [["+p]], options)
vim.keymap.set({ "n", "v" }, "<leader>P", [["+P]], options)
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], options)
vim.keymap.set({ "n", "v" }, "<leader>Y", [["+y$]], options)
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], options)

-- easier indent in visual mode, because it will stay in indent mode
vim.keymap.set("v", "<", "<gv", options)
vim.keymap.set("v", ">", ">gv", options)

-- addtional useful commands
vim.keymap.set("n", "<leader>e", [[/_<CR>l:noh<CR>:let @/=""<CR>]], options)
vim.keymap.set("n", "<leader>m", "ct_", options)
vim.keymap.set("n", "<leader>w", [[/[A-Z]<CR>:noh<CR>:let @/=""<CR>]], options)

-- i hate Q hence nop
vim.keymap.set("n", "Q", "<nop>", options)

-- useful keymaps
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

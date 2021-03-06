local keymap = require("tools.keymap")

-- window controls
keymap.bind("<C-l>"):in_mode("n"):to_command("<C-w>l")
keymap.bind("<C-h>"):in_mode("n"):to_command("<C-w>h")
keymap.bind("<C-j>"):in_mode("n"):to_command("<C-w>j")
keymap.bind("<C-k>"):in_mode("n"):to_command("<C-w>k")
keymap.bind("<leader>-"):in_mode("n"):to_command(":vertical resize -5<CR>")
keymap.bind("<leader>+"):in_mode("n"):to_command(":vertical resize +5<CR>")
-- line mover commands
keymap.bind("<A-j>"):in_mode("n"):to_command(":m .+1<CR>==")
keymap.bind("<A-k>"):in_mode("n"):to_command(":m .-2<CR>==")
keymap.bind("<A-j>"):in_mode("i"):to_command("<Esc>:m .+1<CR>==gi")
keymap.bind("<A-k>"):in_mode("i"):to_command("<Esc>:m .-2<CR>==gi")
keymap.bind("<A-j>"):in_mode("v"):to_command(":m '>+1<CR>gv=gv")
keymap.bind("<A-k>"):in_mode("v"):to_command(":m '<-2<CR>gv=gv")
-- shortcuts for save and close
keymap.bind("<C-q>"):in_mode("n"):to_command(":wq<CR>")
keymap.bind("<C-s>"):in_mode("n"):to_command(":w<CR>")
keymap.bind("<C-q>"):in_mode("i"):to_command("<Esc>:wq<CR>")
keymap.bind("<C-s>"):in_mode("i"):to_command("<Esc>:w<CR>")
keymap.bind("<leader><CR>"):in_mode('n'):to_command(":noh<CR>")
-- disable arrow keys
keymap.deactivate_keys({"<Left>", "<Right>", "<Up>", "<Down>"})

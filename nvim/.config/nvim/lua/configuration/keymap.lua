local map_key = function(mode, keymap, func, desc)
    vim.keymap.set(mode, keymap, func, { silent = true, noremap = true, desc = desc })
end
local map_key_non_silent = function(mode, keymap, func, desc)
    vim.keymap.set(mode, keymap, func, { noremap = true, desc = desc })
end
-- system keymap cannot be deleted, hence overriding
map_key({ "n", "v", "i" }, "<F1>", "<nop>", 'deactivate key')
map_key({ "n", "v", "i" }, "<C-j>", "<nop>", 'deactivate key')
map_key({ "n", "v", "i" }, "<C-k>", "<nop>", 'deactivate key')

-- window controls
map_key("n", "<C-Left>", "<C-w>h", 'Window: jump to left window')
map_key("n", "<C-Right>", "<C-w>l", 'Window: jump to right window')
map_key("n", "<C-Down>", "<C-w>j", 'Window: jump to bottom window')
map_key("n", "<C-Up>", "<C-w>k", 'Window: jump to top window')

-- move half page to center of the screen
map_key("n", "<C-d>", "<C-d>zz", 'Movement: center page down movement')
map_key("n", "<PageDown>", "<C-d>zz", 'Movement: center page down movement')
map_key("n", "<C-u>", "<C-u>zz", 'Movement: center page up movement')
map_key("n", "<PageUp>", "<C-u>zz", 'Movement: center page up movement')

-- keeps cursor on the front
map_key("n", "J", "mzJ`z", 'Merge line: keep cursor on the front ')

-- centers cursor on search
map_key("n", "n", "nzzzv", 'Search: jump to next found element')
map_key("n", "N", "Nzzzv", 'Search: jump to previous found element')

-- Force to work in normal mode
map_key("i", "<Up>", "<Esc><Up>", 'Force to use normal mode')
map_key("i", "<Down>", "<Esc><Down>", 'Force to use normal mode')

-- line mover commands
map_key("n", "<A-Down>", "<CMD>m .+1<CR>==", 'move current line down')
map_key("i", "<A-Down>", "<ESC><CMD>m .+1<CR>==gi", 'move current line down')
map_key("v", "<A-Down>", ":m '>+1<CR>gv=gv", 'move selection down')
map_key("i", "<A-Up>", "<ESC><CMD>m .-2<CR>==gi", 'move current line up')
map_key("n", "<A-Up>", "<CMD>m .-2<CR>==", 'move current line up')
map_key("v", "<A-Up>", ":m '<-2<CR>gv=gv", 'move selection up')

map_key("n", "<A-j>", "<CMD>m .+1<CR>==", 'move current line down')
map_key("i", "<A-j>", "<ESC><CMD>m .+1<CR>==gi", 'move current line down')
map_key("n", "<A-k>", "<CMD>m .-2<CR>==", 'move current line up')
map_key("i", "<A-k>", "<ESC><CMD>m .-2<CR>==gi", 'move current line up')
map_key("v", "<A-j>", ":m '>+1<CR>gv=gv", 'move selection down')
map_key("v", "<A-k>", ":m '<-2<CR>gv=gv", 'move selection up')

-- shortcuts for open, save and close
map_key_non_silent("n", "<leader>o", [[:e <C-R>=expand("%:p:h") . "/"<CR>]], "create new file")
map_key("n", "<C-s>", ":w<CR>", 'fast save of buffer')
map_key("i", "<C-s>", "<Esc>:w<CR>", 'fast save of buffer')
map_key("n", "<C-q>", ":wq<CR>", 'fast quit of nvim')
map_key("i", "<C-q>", "<Esc>:wq<CR>", 'fast quit of nvim')
map_key("i", "<C-q>", "<Esc>:wq<CR>", 'fast quit of nvim')
map_key("n", "<leader><leader>x", ":luafile %<CR>", 'source luafile')

-- simpler copy and paste commands
map_key("v", "p", "\"_dP", 'keeps paste element')
map_key({ "n", "v" }, "<leader>p", [["+p]], 'paste from clipboard')
map_key({ "n", "v" }, "<leader>P", [["+P]], 'paste from clipboard')
map_key({ "n", "v" }, "<leader>y", [["+y]], 'yank to clipboard')
map_key({ "n", "v" }, "<leader>Y", [["+y$]], 'yank to clipboard')
map_key({ "n", "v" }, "<leader>d", [["_d]], 'not working anymore')

-- easier indent in visual mode, because it will stay in indent mode
map_key("v", "<", "<gv", 'keeps selection for another un indent')
map_key("v", ">", ">gv", 'keeps selection for another indent')

-- addtional useful commands
map_key("n", "<leader>e", [[/_<CR>l:noh<CR>:let @/=""<CR>]], 'disable highlight')
map_key("n", "<leader>m", "ct_", '')
map_key("n", "<leader>w", [[/[A-Z]<CR>:noh<CR>:let @/=""<CR>]], 'jump to next uppercase letter')

-- i hate Q hence nop
map_key("n", "Q", "<nop>", '')

-- useful keymaps
map_key_non_silent("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], 'replace word')
map_key("n", "<leader>xx", "<cmd>!chmod +x %<CR>", 'make current file executable')

map_key("n", "[d", vim.diagnostic.goto_prev, 'goto previous [d]iagnostic')
map_key("n", "]d", vim.diagnostic.goto_next, 'goto next [d]iagnostic')
map_key("n", "<leader>e", vim.diagnostic.open_float, 'open float')
map_key("n", "<leader>q", vim.diagnostic.setloclist, 'set local list')

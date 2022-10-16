require('toggleterm').setup({
    persist_size = false,
    shade_terminals = false,
    shade_factor = '2',
    shell = vim.o.shell,
})

local terminal = require('toggleterm.terminal').Terminal

local lazygit = terminal:new({
    cmd = "lazygit",
    dir = 'git_dir',
    hidden = true,
    direction = 'float'
})

local lazygit_toggle = function()
    lazygit:toggle()
end

local toggle_term = function()
    local option = { nargs = "*", count = true }
    require('toggleterm').toggle_command(option.args, 2)
end

vim.keymap.set("n", "<leader>lg", lazygit_toggle, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>t", toggle_term, { noremap = true, silent = true })
vim.keymap.set("t", "<C-A-Space>", [[<C-\><C-n>]], { noremap = true, silent = true })
vim.keymap.set("t", "<C-left>", [[<C-\><C-n><C-w>h]], { noremap = true, silent = true })
vim.keymap.set("t", "<C-right>", [[<C-\><C-n><C-w>l]], { noremap = true, silent = true })
vim.keymap.set("t", "<C-down>", [[<C-\><C-n><C-w>j]], { noremap = true, silent = true })
vim.keymap.set("t", "<C-up>", [[<C-\><C-n><C-w>k]], { noremap = true, silent = true })

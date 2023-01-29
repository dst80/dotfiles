local M = {
    "akinsho/toggleterm.nvim",
    lazy = true,
    keys = {
        { "<leader>t", "ToggleTerm", desc = '[t]oggle terminal' }
    }
}

function M.config()
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

    local map = function(mode, keys, func, desc)
        if desc then
            desc = 'Terminal: ' .. desc
        end
        vim.keymap.set(mode, keys, func, { noremap = true, silent = true, desc = desc })
    end

    map("n", "<leader>lg", lazygit_toggle, '[l]azy[g]it toggle')
    map("n", "<leader>t", toggle_term, '[t]erminal toggle')
    map("t", "<C-A-Space>", [[<C-\><C-n>]], 'goto ex mode in terminal')
    map("t", "<C-left>", [[<C-\><C-n><C-w>h]], 'goto left window from terminal')
    map("t", "<C-right>", [[<C-\><C-n><C-w>l]], 'goto right window from terminal')
    map("t", "<C-down>", [[<C-\><C-n><C-w>j]], 'goto lower window from terminal')
    map("t", "<C-up>", [[<C-\><C-n><C-w>k]], 'goto upper window from terminal')
end

return M

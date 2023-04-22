local M = {

}

function M.map(mode, key, func)
    vim.keymap.set(mode, key.key, func, { silent = true, noremap = true, desc = key.desc })
end

function M.map_non_silent(mode, key, func)
    vim.keymap.set(mode, key.key, func, { noremap = true, desc = key.desc })
end

M.list = {
    --  Bufferline
    switch_next_buffer = { key = "<C-b><C-n>", desc = "Bufferline: [b]uffer [p]revious" },
    switch_previous_buffer = { key = "<C-b><C-p>", desc = "Bufferline: [b]uffer [n]ext" },
    move_next_buffer = { key = "<C-b><C-m><C-n>", desc = "Bufferline: [b]uffer [m]ove to [n]ext" },
    move_previous_buffer = { key = "<C-b><C-m><C-p>", desc = "Bufferline: [b]uffer [m]ove to [p]revious" },
    select_buffer_1 = { key = "<leader>1", desc = "Bufferline: switch to buffer [1]" },
    select_buffer_2 = { key = "<leader>2", desc = "Bufferline: switch to buffer [2]" },
    select_buffer_3 = { key = "<leader>3", desc = "Bufferline: switch to buffer [3]" },
    select_buffer_4 = { key = "<leader>4", desc = "Bufferline: switch to buffer [4]" },
    select_buffer_5 = { key = "<leader>5", desc = "Bufferline: switch to buffer [5]" },
    select_buffer_6 = { key = "<leader>6", desc = "Bufferline: switch to buffer [6]" },
    select_buffer_7 = { key = "<leader>7", desc = "Bufferline: switch to buffer [7]" },
    select_buffer_8 = { key = "<leader>8", desc = "Bufferline: switch to buffer [8]" },
    select_buffer_9 = { key = "<leader>9", desc = "Bufferline: switch to buffer [9]" },
    -- File browser
    toggle_file_browser = { key = "<leader>e", desc = "file [e]xplorer" },
}

function M.bufferline()
end

function M.file_explorer()
    M.map("n", M.list.toggle_file_browser, "<cmd>NvimTreeToggle<cr>")
end

function M.setup()
    M.file_explorer()
end

return M

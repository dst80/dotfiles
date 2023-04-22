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
    -- Telescope
    show_buffer_overview = { key = "<leader>sb", desc = "Telescope: [s]how [b]buffer overview" },
    show_diagnostics_overview = { key = "<leader>so", desc = "Telescope: [s]how [d]iagnostics" },
    search_fuzzy_buffer = { key = "<leader>/", desc = "Telescope: search fuzzy in current buffer" },
    search_file = { key = "<leader>sf", desc = "Telescope: [s]earch [f]ile" },
    search_old_file = { key = "<leader>sof", desc = "Telescope: [s]earch [o]ld [f]ile" },
    search_hidden_file = { key = "<leader>shf", desc = "Telescope: [s]earch [h]idden [f]ile" },
    search_help = { key = "<leader>sh", desc = "Telescope: [s]earch [h]elp" },
    search_word = { key = "<leader>sw", desc = "Telescope: [s]earch current [w]ord" },
    search_by_grep = { key = "<leader>sg", desc = "Telescope: [s]earch by [g]rep" },
    search_dotfiles = { key = "<leader>sdf", desc = "Telescope: [s]earch [d]ot[f]iles" },
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

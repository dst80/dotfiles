require'lualine'.setup {
    options = {lower = true, theme = 'nord'},
    sections = {lualine_a = {{'mode', lower = false}}, lualine_b = {'branch'}}
}

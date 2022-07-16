require 'lualine'.setup {
    options = {
        lower = true,
        theme = 'nord',
        icons_enabled = 1,
        component_separators = {
            left = '',
            right = ''
        },
        section_separators = {
            left = '',
            right = ''
        }
    },
    sections = {
        lualine_a = { { 'mode', lower = false } },
        lualine_b = { 'branch' },
        lualine_c = { 'filename' },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
    }
}

local M = {
    "hoob3rt/lualine.nvim",
    dependencies = {
        "navarasu/onedark.nvim",
    },
}

function M.config()
    require 'lualine'.setup {
        options = {
            lower = true,
            theme = 'auto',
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
end

return M;

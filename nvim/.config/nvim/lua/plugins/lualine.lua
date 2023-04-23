local M = {
    "hoob3rt/lualine.nvim",
}

M.diagnostics = {
    'diagnostics',
    sources = { 'nvim_diagnostic' },
    sections = { 'error', 'warn', 'info', 'hint' },
    diagnostics_color = {
        error = 'DiagnosticError',
        warn  = 'DiagnosticWarn',
        info  = 'DiagnosticInfo',
        hint  = 'DiagnosticHint',
    },
    symbols = {
        error = " ",
        warn = " ",
        hint = " ",
        info = " "
    },
    colored = true,
    update_in_insert = true,
    always_visible = true,
}

function M.config()
    require "lualine".setup {
        options = {
            lower = true,
            theme = "auto",
            icons_enabled = 1,
            component_separators = {
                left = "",
                right = ""
            },
            section_separators = {
                left = "",
                right = ""
            }
        },
        sections = {
            lualine_a = { { "mode", lower = false } },
            lualine_b = { "branch" },
            lualine_c = { "filename" },
            lualine_x = { M.diagnostics },
            lualine_y = { "encoding", "fileformat", "filetype" },
            lualine_z = { "progress", "location" }
        }
    }
end

return M;

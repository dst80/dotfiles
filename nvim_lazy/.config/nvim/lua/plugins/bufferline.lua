local M = {
    'noib3/nvim-cokeline',
    dependencies = {
        "nvim-tree/nvim-web-devicons"
    }
}

function M.config()
    local get_hex = require('cokeline/utils').get_hex
    local normal_fg = get_hex('Normal', "fg")
    local normal_bg = get_hex('Normal', "bg")
    local comment_fg = get_hex('Comment', "fg")
    local cursor_coloum_bg = get_hex('CursorColumn', "bg")
    local tree_bg = get_hex('NvimTreeNormal', "bg")


    require('cokeline').setup({
        default_hl = {
            fg = function()
                return normal_fg
            end,
            bg = function(buffer)
                return buffer.is_focused and normal_bg or cursor_coloum_bg
            end
        },
        sidebar = {
            filetype = 'NvimTree',
            components = {
                {
                    text = '  File Explorer',
                    fg = normal_fg,
                    bg = tree_bg,
                    style = 'bold',
                },
            }
        },
        components = {
            {
                text = function(buffer)
                    return ' ' .. buffer.devicon.icon
                end,

                fg = function(buffer)
                    return buffer.devicon.color
                end,
            },
            {
                text = function(buffer)
                    return buffer.unique_prefix
                end,

                fg = comment_fg,
                style = 'italic',
            },
            {
                text = function(buffer)
                    return buffer.filename .. ' '
                end,

                fg = function(buffer)
                    return buffer.is_focused and normal_fg or comment_fg
                end,

                style = function(buffer)
                    return buffer.is_focused and "bold" or nil
                end
            },
            {
                text = '',
                delete_buffer_on_left_click = true,
            },
            {
                text = ' ',
            }
        },
    })

    local map = function(mode, keys, func, desc)
        if desc then
            desc = 'BufferLine: ' .. desc
        end
        vim.keymap.set(mode, keys, func, { noremap = true, silent = true, desc = desc })
    end

    map("n", "<C-b><C-n>", [[<Plug>(cokeline-focus-next)]], '[b]uffer [n]ext')
    map("n", "<C-b><C-p>", [[<Plug>(cokeline-focus-prev)]], '[b]uffer [p]revious')
    map("n", "<C-b><C-m><C-n>", [[<Plug>(cokeline-switch-next)]], '[b]uffer [m]ove [n]ext')
    map("n", "<C-b><C-m><C-p>", [[<Plug>(cokeline-switch-prev)]], '[b]uffer [m]ove [p]revious')
    map("n", "<leader>1", [[<Plug>(cokeline-focus-1)]], 'goto buffer [1]')
    map("n", "<leader>2", [[<Plug>(cokeline-focus-2)]], 'goto buffer [2]')
    map("n", "<leader>3", [[<Plug>(cokeline-focus-3)]], 'goto buffer [3]')
    map("n", "<leader>4", [[<Plug>(cokeline-focus-4)]], 'goto buffer [4]')
    map("n", "<leader>5", [[<Plug>(cokeline-focus-5)]], 'goto buffer [5]')
    map("n", "<leader>6", [[<Plug>(cokeline-focus-6)]], 'goto buffer [6]')
    map("n", "<leader>7", [[<Plug>(cokeline-focus-7)]], 'goto buffer [7]')
    map("n", "<leader>8", [[<Plug>(cokeline-focus-8)]], 'goto buffer [8]')
    map("n", "<leader>9", [[<Plug>(cokeline-focus-9)]], 'goto buffer [9]')
end

return M

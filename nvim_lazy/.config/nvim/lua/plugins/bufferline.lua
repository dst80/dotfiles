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

    local keymap = require("plugin_keymaps");

    keymap.map("n", keymap.list.move_next_buffer, [[<Plug>(cokeline-switch-next)]])
    keymap.map("n", keymap.list.switch_next_buffer, [[<Plug>(cokeline-focus-next)]])
    keymap.map("n", keymap.list.move_previous_buffer, [[<Plug>(cokeline-switch-prev)]])
    keymap.map("n", keymap.list.switch_previous_buffer, [[<Plug>(cokeline-focus-prev)]])
    keymap.map("n", keymap.list.select_buffer_1, [[<Plug>(cokeline-focus-1)]])
    keymap.map("n", keymap.list.select_buffer_2, [[<Plug>(cokeline-focus-2)]])
    keymap.map("n", keymap.list.select_buffer_3, [[<Plug>(cokeline-focus-3)]])
    keymap.map("n", keymap.list.select_buffer_4, [[<Plug>(cokeline-focus-4)]])
    keymap.map("n", keymap.list.select_buffer_5, [[<Plug>(cokeline-focus-5)]])
    keymap.map("n", keymap.list.select_buffer_6, [[<Plug>(cokeline-focus-6)]])
    keymap.map("n", keymap.list.select_buffer_7, [[<Plug>(cokeline-focus-7)]])
    keymap.map("n", keymap.list.select_buffer_8, [[<Plug>(cokeline-focus-8)]])
    keymap.map("n", keymap.list.select_buffer_9, [[<Plug>(cokeline-focus-9)]])
end

return M

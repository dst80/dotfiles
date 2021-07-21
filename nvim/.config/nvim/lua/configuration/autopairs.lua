if not pcall(require, "nvim-autopairs") then
    return
end

require("nvim-autopairs").setup({
        ignored_next_char = "[%w%.]",
        enable_check_bracket_line = false,
        check_ts = true,
        ts_config = {
            lua = {'string'},
            javascript = {'template_string'},
            java = false,
        }
    })

if not pcall(require, "nvim-autopairs.completion.compe") then
    return
end

require("nvim-autopairs.completion.compe").setup({
        map_cr = true,
        map_complete = true
    })

if not pcall(require, "nvim-treesitter.configs") then
    return
end

require('nvim-treesitter.configs').setup {
        autopairs = {enable = true}
    }


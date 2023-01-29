local M = {
    "windwp/nvim-autopairs",
    lazy = true,
    event = "BufReadPost"
}

function M.config()
    require("nvim-autopairs").setup({
        disable_filetype = { "TelescopePrompt", "vim" },
        ignored_next_char = "[%w%.]",
        enable_check_bracket_line = false,
        check_ts = true,
        ts_config = {
            lua = { 'string' },
            javascript = { 'template_string' },
            java = false,
        },
        fast_wrap = {
            map = '<M-e>',
            chars = { '{', '[', '(', '"', "'" },
            pattern = [=[[%'%"%)%>%]%)%}%,]]=],
            end_key = '$',
            keys = 'qwertyuiopzxcvbnmasdfghjkl',
            check_comma = true,
            highlight = 'Search',
            highlight_grey = 'Comment'
        },
    })

    local Rule = require('nvim-autopairs.rule')
    local ts_conds = require('nvim-autopairs.ts-conds')
    -- press % => %% only while inside a comment or string
    require('nvim-autopairs').add_rules({
        Rule("%", "%", "lua")
            :with_pair(ts_conds.is_ts_node({ 'string', 'comment' })),
        Rule("$", "$", "lua")
            :with_pair(ts_conds.is_not_ts_node({ 'function' }))
    })

    local cmp_autopairs = require('nvim-autopairs.completion.cmp')
    require('cmp').event:on('confirm_done', cmp_autopairs.on_confirm_done({
        map_char = { tex = '' }
    }))
end

return M

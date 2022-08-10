require('Comment.api').setup({
    padding = true,
    sticky = true,
    mappings = {
        basic = true,
        extra = true,
        extended = true,
    },
    toggler = {
        line = 'gcc',
        block = 'gbc',
    },
    opleader = {
        line = 'gc',
        block = 'gb',
    },
    extra = {
        above = 'gcO',
        below = 'gco',
        eol = 'gcA',
    },
})

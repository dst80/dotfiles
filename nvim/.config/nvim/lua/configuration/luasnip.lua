-- if vim.g.snippets ~= "luasnip" or not pcall(require, "luasnip") then
--   return
-- end

local luasnip = require('luasnip')
local types = require('luasnip.util.types')

luasnip.config.setup({
    history = true,
    update_events = "TextChanged,TextChangedI",
    --update_events = "InsertLeave",
    enable_autosnippets = true,
    region_check_events = "CursorHold,InsertLeave",
    delete_check_events = "TextChanged,InsertEnter",
    ext_opts = {
        [types.choiceNode] = {
            active = {
                virt_text = { { " Current choice", "NonText" } },
                priority = 0
            },
        },
    },
})

require('luasnip.loaders.from_vscode').lazy_load({
    paths = {
        "~/.config/snippets/vsc-snippets"
    }
})

require('luasnip.loaders.from_lua').lazy_load({
    paths = {
        '~/.config/nvim/lua/configuration/luasnip/filetypes'
    }
})

vim.keymap.set({ "i", "s" }, "<C-j>", function()
    if luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
    end
end, { silent = true })

-- <c-j> is my jump backwards key.
-- this always moves to the previous item within the snippet
vim.keymap.set({ "i", "s" }, "<C-k>", function()
    if luasnip.jumpable(-1) then
        luasnip.jump(-1)
    end
end, { silent = true })

-- <c-l> is selecting within a list of options.
-- This is useful for choice nodes (introduced in the forthcoming episode 2)
vim.keymap.set({ "i", "s" }, "<C-h>", function()
    if luasnip.choice_active() then
        luasnip.change_choice(-1)
    end
end)
vim.keymap.set({ "i", "s" }, "<C-l>", function()
    if luasnip.choice_active() then
        luasnip.change_choice(1)
    end
end)

vim.keymap.set("i", "<C-u>", require "luasnip.extras.select_choice")

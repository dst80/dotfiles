local has_luasnip, luasnip = pcall(require, "luasnip")
if not has_luasnip then
    return
end

local types = require('luasnip.util.types')

luasnip.config.setup({
    history = true,
    update_events = "TextChanged,TextChangedI",
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

local has_vsc_ldr, vsc_ldr = pcall(require, 'luasnip.loaders.from_vscode')
if has_vsc_ldr then
    vsc_ldr.lazy_load(
        { paths = { "~/.config/snippets/vsc-snippets" } }
    )
end

local has_lua_ldr, lua_ldr = pcall(require, 'luasnip.loaders.from_lua')
if has_lua_ldr then
    lua_ldr.lazy_load(
        { paths = { '~/.config/nvim/lua/configuration/luasnip/filetypes' } }
    )
end

vim.keymap.set({ "i", "s" }, "<C-j>", function()
    if luasnip.expand_or_jumpable() then luasnip.expand_or_jump() end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<C-k>", function()
    if luasnip.jumpable(-1) then luasnip.jump(-1) end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<C-h>", function()
    if luasnip.choice_active() then luasnip.change_choice(-1) end
end)
vim.keymap.set({ "i", "s" }, "<C-l>", function()
    if luasnip.choice_active() then luasnip.change_choice(1) end
end)

vim.keymap.set("i", "<C-u>", require "luasnip.extras.select_choice")

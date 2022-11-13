local tabnine = require("cmp_tabnine.config")
tabnine:setup({
    max_lines = 1000,
    max_num_results = 10,
    sort = true,
    run_on_every_keystroke = true,
    snippet_placeholder = "..",
})

local lspkind = require("lspkind")
local source_mapping = {
    nvim_lua = "[Lua]",
    nvim_lsp = "[LSP]",
    path = "[Path]",
    luasnip = "[Snip]",
    buffer = "[Buffer]",
    cmp_tabnine = "[TN]",
}

local lspkind_format_function = function(entry, vim_item)
    vim_item.kind = lspkind.presets.default[vim_item.kind]
    local menu = source_mapping[entry.source.name]
    if entry.source.name == "cmp_tabnine" then
        local data = entry.completion_item.data
        if data ~= nil and data.detail ~= nil then
            menu = data.detail .. " " .. menu
        end
        vim_item.kind = ""
    end
    vim_item.menu = menu
    return vim_item
end

local cmp = require('cmp')
local luasnip = require('luasnip')

local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    local prev_line = vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1];
    return col ~= 0 and prev_line:sub(col, col):match("%s") == nil
end

local tab_mapping = function(fallback)
    if cmp.visible() then cmp.select_next_item()
    elseif luasnip.expand_or_jumpable() then luasnip.expand_or_jump()
    elseif has_words_before() then cmp.complete()
    else fallback()
    end
end

local super_tab_mapping = function(fallback)
    if cmp.visible() then cmp.select_prev_item()
    elseif luasnip.jumpable(-1) then luasnip.jump(-1)
    else fallback()
    end
end

local confirm_config = {
    behavior = cmp.ConfirmBehavior.Insert,
    select = true
}

local expand_function = function(args)
    luasnip.lsp_expand(args.body)
end

cmp.setup({
    completion = { keyword_length = 2, },
    experimental = { native_menu = false, ghost_text = true },
    formatting = { format = lspkind_format_function },
    mapping = {
        ['<C-v>'] = cmp.mapping.scroll_docs(-4),
        ['<C-m>'] = cmp.mapping.scroll_docs(4),
        ['<C-b>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<Tab>'] = cmp.mapping(tab_mapping, { "i", "s" }),
        ['<S-Tab>'] = cmp.mapping(super_tab_mapping, { "i", "s" }),
        ['<C-e>'] = cmp.mapping.close(),
        ['<C-y>'] = cmp.mapping.confirm(confirm_config),
        ['<CR>'] = cmp.mapping.confirm(confirm_config),
    },
    preselect = cmp.PreselectMode.None,
    snippet = { expand = expand_function },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'cmp_tabnine' },
        { name = 'buffer', keyword_length = 5 },
        { name = 'luasnip', priority = 500 },
        { name = 'nvim_lua' },
        { name = 'path' },
    },
})

local run_command = '';
if (vim.loop.os_uname().sysname == "Windows_NT") then
    run_command = "powershell ./install.ps1"
else
    run_command = "./install.sh"
end

local M = {
    "hrsh7th/nvim-cmp",
    dependencies = {
        { "hrsh7th/cmp-nvim-lsp" },
        { "hrsh7th/cmp-nvim-lua" },
        { "hrsh7th/cmp-path" },
        { "hrsh7th/cmp-buffer" },
        { "hrsh7th/cmp-cmdline" },
        { "L3MON4D3/LuaSnip" },
        { "saadparwaiz1/cmp_luasnip" },
        { "tzachar/cmp-tabnine",     build = run_command },
        { "onsails/lspkind.nvim" },
        { "nvim-lua/plenary.nvim" },
        { "zbirenbaum/copilot-cmp" },
    },
    event = "BufReadPost",
    lazy = true,
}

function M.config()
    require("copilot").setup({
        suggestion = { enabled = false },
        panel = { enabled = false },
    })
    require("copilot_cmp").setup()

    -- lspkind
    local lspkind = require("lspkind")
    local source_mapping = {
        nvim_lua = "[Lua]",
        nvim_lsp = "[LSP]",
        path = "[Path]",
        luasnip = "[Snip]",
        buffer = "[Buffer]",
        cmp_tabnine = "[TN]",
        cmdline = "[CMD]",
        copilot = "[Pilot]",
    }

    local lspkind_format_function = function(entry, vim_item)
        vim_item.kind = lspkind.presets.default[vim_item.kind]
        vim_item.menu = source_mapping[entry.source.name]
        if entry.source.name == "cmp_tabnine" then
            local detail = (entry.completion_item.data or {}).detail
            vim_item.kind = ""
            if detail and detail:find('.*%%.*') then
                vim_item.kind = vim_item.kind .. ' ' .. detail
            end

            if (entry.completion_item.data or {}).multiline then
                vim_item.kind = vim_item.kind .. ' ' .. '[ML]'
            end
        end
        local maxwidth = 80
        vim_item.abbr = string.sub(vim_item.abbr, 1, maxwidth)
        return vim_item
    end

    -- luasnip
    local has_luasnip, luasnip = pcall(require, "luasnip")
    if not has_luasnip then return end

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


    local config_path = require("plenary.path"):new(vim.fn.stdpath("config"))
    local vsc_snippet_path = config_path:parent():joinpath("snippets", "vsc-snippets"):absolute()

    local has_vsc_ldr, vsc_ldr = pcall(require, 'luasnip.loaders.from_vscode')
    if has_vsc_ldr then vsc_ldr.lazy_load({ paths = { vsc_snippet_path } }) end

    -- local has_lua_ldr, lua_ldr = pcall(require, 'luasnip.loaders.from_lua')
    -- if has_lua_ldr then
    --     lua_ldr.lazy_load(
    --         { paths = { '~/.config/nvim/lua/configuration/luasnip/filetypes' } }
    --     )
    -- end

    local has_cmp, cmp = pcall(require, 'cmp')
    if (not has_cmp) then return end

    local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        local prev_line = vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1];
        return col ~= 0 and prev_line:sub(col, col):match("%s") == nil
    end

    local tab_mapping = function(fallback)
        if cmp.visible() then
            cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
        elseif has_words_before() then
            cmp.complete()
        else
            fallback()
        end
    end

    local super_tab_mapping = function(fallback)
        if cmp.visible() then
            cmp.select_prev_item()
        elseif luasnip.jumpable( -1) then
            luasnip.jump( -1)
        else
            fallback()
        end
    end

    local enter_mapping = function(fallback)
        if cmp.get_selected_entry() ~= nil then
            cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
        else
            fallback()
        end
    end

    local window_desc = cmp.config.window.bordered({
            border = { ' ', '', ' ', ' ', ' ', '', ' ', ' ' },
            scrollbar = true,
            side_padding = 0,
            winhighlight = 'Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:Match',
        });

    cmp.setup({
        completion = { keyword_length = 1, },
        formatting = { format = lspkind_format_function },
        mapping = {
            ['<C-d>'] = cmp.mapping.scroll_docs( -4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete({}),
            ['<C-S>'] = cmp.mapping.complete({ config = { sources = { { name = "vsnip" } } } }),
            ['<CR>'] = enter_mapping,
            ['<Tab>'] = cmp.mapping(tab_mapping, { "i", "s" }),
            ['<S-Tab>'] = cmp.mapping(super_tab_mapping, { "i", "s" }),
            ['<C-e>'] = cmp.mapping.close(),
        },
        preselect = cmp.PreselectMode.None,
        snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
        sources = {
            { name = 'nvim_lsp', max_item_count = 50, priority = 4, group_index = 1, },
            { name = 'copilot',  max_item_count = 10, priority = 3, group_index = 1, keyword_length = 2 },
            { name = 'luasnip',  max_item_count = 10, priority = 3, group_index = 1, },
            { name = 'path',     max_item_count = 10, priority = 2, group_index = 1, trigger_characters = { "\\", "/" } },
            { name = 'buffer',   max_item_count = 10, priority = 2, group_index = 2 },
        },
        window = {
            completion = window_desc,
            documentation = window_desc,
        },
    })

    cmp.setup.filetype({ "lua" }, {
        sources = {
            { name = 'nvim_lsp', max_item_count = 50, priority = 4, group_index = 1, },
            { name = 'copilot',  max_item_count = 10, priority = 3, group_index = 1, keyword_length = 2 },
            { name = 'luasnip',  max_item_count = 10, priority = 3, group_index = 1, },
            { name = 'path',     max_item_count = 10, priority = 2, group_index = 1, trigger_characters = { "\\", "/" } },
            { name = 'nvim_lua', max_item_count = 10, priority = 1, group_index = 1, },
            { name = 'buffer',   max_item_count = 10, priority = 2, group_index = 2, },
        }
    })

    -- `/` cmdline setup.
    cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
            { name = 'buffer' }
        }
    })

    cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
            { name = 'cmdline' },
            { name = 'path' }
        })
    })
end

return M

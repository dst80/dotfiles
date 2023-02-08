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
        { "zbirenbaum/copilot.lua" },
        { "zbirenbaum/copilot-cmp" },
    },
    event = "BufReadPost",
    lazy = true,
    cmd = "InitCmp",
}

function M.config()
    -- tabnine
    local tabnine = require("cmp_tabnine.config")
    tabnine:setup({
        max_lines = 200,
        max_num_results = 10,
        sort = true,
        run_on_every_keystroke = true,
        snippet_placeholder = "..",
    })
    local prefetch = vim.api.nvim_create_augroup("prefetch", { clear = true })
    vim.api.nvim_create_autocmd('BufRead', {
        group = prefetch,
        callback = function()
            require('cmp_tabnine'):prefetch(vim.fn.expand('%:p'))
        end
    })

    local copilot = require("copilot").setup()
    local copilot_cmp = require("copilot_cmp").setup()

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
    local path = require("plenary.path")
    local config_path = path:new(vim.fn.stdpath("config"))
    local vsc_snippet_path = config_path:parent():joinpath("snippets", "vsc-snippets"):absolute()
    local has_vsc_ldr, vsc_ldr = pcall(require, 'luasnip.loaders.from_vscode')
    if has_vsc_ldr then
        vsc_ldr.lazy_load({ paths = { vsc_snippet_path } })
    end

    -- local has_lua_ldr, lua_ldr = pcall(require, 'luasnip.loaders.from_lua')
    -- if has_lua_ldr then
    --     lua_ldr.lazy_load(
    --         { paths = { '~/.config/nvim/lua/configuration/luasnip/filetypes' } }
    --     )
    -- end

    local cmp = require('cmp')

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

    local confirm_config = {
        behavior = cmp.ConfirmBehavior.Replace,
        select = true
    }

    local expand_function = function(args)
        luasnip.lsp_expand(args.body)
    end

    local compare = require('cmp.config.compare')

    local window_config = cmp.config.window.bordered()
    window_config.border = "none"

    local WIDE_HEIGHT = 40
    cmp.setup({
        completion = { keyword_length = 1, },
        experimental = { ghost_text = true },
        formatting = { format = lspkind_format_function },
        mapping = {
            ['<C-d>'] = cmp.mapping.scroll_docs( -4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete({}),
            ['<C-S>'] = cmp.mapping.complete({
                config = {
                    sources = {
                        { name = "vsnip" }
                    }
                },
            }),
            ['<CR>'] = cmp.mapping.confirm(confirm_config),
            ['<Tab>'] = cmp.mapping(tab_mapping, { "i", "s" }),
            ['<S-Tab>'] = cmp.mapping(super_tab_mapping, { "i", "s" }),
            ['<C-e>'] = cmp.mapping.close(),
        },
        preselect = cmp.PreselectMode.None,
        snippet = { expand = expand_function },
        sources = {
            { name = 'copilot',     max_item_count = 10, priority = 300, group_index = 1 },
            { name = 'cmp_tabnine', max_item_count = 10, priority = 300, group_index = 1 },
            { name = 'nvim_lsp',    max_item_count = 10, priority = 300, group_index = 1 },
            { name = 'luasnip',     max_item_count = 10, priority = 300, group_index = 1 },
            { name = 'path',        max_item_count = 10, priority = 300, group_index = 1 },
            { name = 'nvim_lua',    max_item_count = 10, priority = 100, group_index = 2 },
        },
        {
            { name = 'buffer' },
        },
        sorting = {
            priority_weight = 2,
            comparators = {
                require('cmp_tabnine.compare'),
                compare.offset,
                compare.exact,
                compare.score,
                compare.recently_used,
                compare.kind,
                compare.sort_text,
                compare.length,
                compare.order,
            },
        },
        window = {
            completion = {
                border = nil,
                winhighlight = 'Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None',
                scrolloff = 0,
                scrollbar = true,
                col_offset = 0,
                side_padding = 1,
            },
            documentation = {
                border = nil,
                max_height = math.floor(WIDE_HEIGHT * (WIDE_HEIGHT / vim.o.lines)),
                max_width = math.floor((WIDE_HEIGHT * 2) * (vim.o.columns / (WIDE_HEIGHT * 2 * 16 / 9))),
                winhighlight = 'FloatBorder:NormalFloat',
            },
        },
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
            { name = 'path' }
        }, {
            { name = 'cmdline' }
        })
    })
end

return M

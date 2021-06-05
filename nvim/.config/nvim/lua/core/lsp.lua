local sumneko_root_path = '/home/dennis/repos/lua-language-server'
local sumneko_binary = sumneko_root_path .. "/bin/Linux/lua-language-server"
local function on_attach()
    -- TODO: TJ told me to do this and I should do it because he is Telescopic
    -- "Big Tech" "Cash Money" Johnson
end
require'lspconfig'.tsserver.setup{ on_attach=on_attach }
require'lspconfig'.clangd.setup {
    on_attach = on_attach,
    root_dir = function() return vim.loop.cwd() end
}

require'lspconfig'.pyls.setup{ on_attach=on_attach }
require'lspconfig'.gopls.setup{ on_attach=on_attach }
-- who even uses this?
require'lspconfig'.rust_analyzer.setup{ on_attach=on_attach }

-- whether to show outline guides
require'lspconfig'.sumneko_lua.setup {
    on_attach = on_attach,
    cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
                path = vim.split(package.path, ';'),
            },
            diagnostics = {
                globals = {'vim'},
            },
            workspace = {
                library = {
                    [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                    [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
                },
            },
        },
    },
}

local opts = {
    -- whether to highlight the currently hovered symbol
    -- disable if your cpu usage is higher than you want it
    -- or you just hate the highlight
    -- default: true
    highlight_hovered_item = true,

-- default: true
    show_guides = true,
}

require('symbols-outline').setup(opts)

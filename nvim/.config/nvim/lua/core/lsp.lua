local sumneko_root_path = '/home/dennis/repos/lua-language-server'
local sumneko_binary = sumneko_root_path .. "/bin/Linux/lua-language-server"

local on_attach = function(client)
   require'completion'.on_attach(client)
end

require'lspconfig'.tsserver.setup{ on_attach=on_attach }
require'lspconfig'.clangd.setup {
    on_attach = on_attach,
    root_dir = function() return vim.loop.cwd() end
}

require'lspconfig'.pyls.setup{ on_attach=on_attach }
require'lspconfig'.gopls.setup{ on_attach=on_attach }
require'lspconfig'.rust_analyzer.setup{ on_attach=on_attach }

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
    highlight_hovered_item = true,
    show_guides = true,
}

require('symbols-outline').setup(opts)

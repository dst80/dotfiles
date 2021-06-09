local sumneko_root_path = '/home/dennis/repos/lua-language-server'
local sumneko_binary = sumneko_root_path .. "/bin/Linux/lua-language-server"

vim.api.nvim_buf_set_option(0, 'omnifunc', 'v:lua.vim.lsp.omnifunc')


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

local keymap = require('core.tools.keymap')
-- LSP shortcuts
keymap.bind("gD"):to_lua_command("vim.lsp.buf.declaration()")
keymap.bind("gd"):to_lua_command("vim.lsp.buf.definition()")
keymap.bind("gi"):to_lua_command("vim.lsp.buf.implementation()")
keymap.bind("gr"):to_lua_command("vim.lsp.buf.references()")
keymap.bind("<leader>i"):to_lua_command("vim.lsp.buf.hover()")
keymap.bind("<leader>sh"):to_lua_command("vim.lsp.buf.signature_help()")
keymap.bind("<leader>wa"):to_lua_command("vim.lsp.buf.add_workspace_folder()")
keymap.bind("<leader>wr"):to_lua_command("vim.lsp.buf.remove_workspace_folder()")
keymap.bind("<leader>wl"):to_lua_command("print(vim.inspect(vim.lsp.buf.list_workspace_folders()))")
keymap.bind("<leader>td"):to_lua_command("vim.lsp.buf.type_definition()")
keymap.bind("<leader>rn"):to_lua_command("vim.lsp.buf.rename()")
keymap.bind("<leader>ca"):to_lua_command("vim.lsp.buf.code_action()")
keymap.bind("<leader>sd"):to_lua_command("vim.lsp.diagnostic.show_line_diagnostics()")
keymap.bind("<leader>gpd"):to_lua_command("vim.lsp.diagnostic.goto_prev()")
keymap.bind("<leader>gnd"):to_lua_command("vim.lsp.diagnostic.goto_next()")
keymap.bind("<leader>ll"):to_lua_command("vim.lsp.diagnostic.set_loclist()")
keymap.bind("<leader>fo"):to_lua_command("vim.lsp.buf.formatting()")


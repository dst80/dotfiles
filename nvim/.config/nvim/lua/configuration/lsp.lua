local sumneko = require('configuration.sumneko')
local lspconfig = require('lspconfig')
local util = require('lspconfig/util')

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

local on_attach = function(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
end

lspconfig.clangd.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = {
        "c", "cc", "cpp", "cxx", "h", "hpp", "hxx", "objc", "objcc"
    },
    single_file_support = true,
}

lspconfig.tsserver.setup {
    on_attach = on_attach,
    capabilities = capabilities
}

-- require('lspconfig').pyright.setup {
--     on_attach = on_attach,
--     capabilities = capabilities
-- }

lspconfig.gopls.setup {
    on_attach = on_attach,
    capabilities = capabilities
}

lspconfig.rust_analyzer.setup {
    on_attach = on_attach,
    capabilities = capabilities
}

lspconfig.sumneko_lua.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = {sumneko.binary, "-E", sumneko.root .. "/main.lua"},
    settings = {
        Lua = {
            runtime = {version = 'LuaJIT', path = vim.split(package.path, ';')},
            diagnostics = {globals = {'vim'}},
            workspace = {
                library = {
                    [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                    [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
                    [vim.fn.stdpath('config') .. "/lua"] = true
                }
            }
        }
    }
}

local keymap = require('tools.keymap')
-- LSP shortcuts
keymap.bind("gD"):to_lua_command("vim.lsp.buf.declaration()")
keymap.bind("gd"):to_lua_command("vim.lsp.buf.definition()")
keymap.bind("gi"):to_lua_command("vim.lsp.buf.implementation()")
keymap.bind("gr"):to_lua_command("vim.lsp.buf.references()")
keymap.bind("<leader>i"):to_lua_command("vim.lsp.buf.hover()")
keymap.bind("<leader>sh"):to_lua_command("vim.lsp.buf.signature_help()")
keymap.bind("<leader>wa"):to_lua_command("vim.lsp.buf.add_workspace_folder()")
keymap.bind("<leader>wr"):to_lua_command("vim.lsp.buf.remove_workspace_folder()")
keymap.bind("<leader>wl"):to_lua_command(
    "print(vim.inspect(vim.lsp.buf.list_workspace_folders()))")
keymap.bind("<leader>td"):to_lua_command("vim.lsp.buf.type_definition()")
keymap.bind("<leader>rn"):to_lua_command("vim.lsp.buf.rename()")
keymap.bind("<leader>ca"):to_lua_command("vim.lsp.buf.code_action()")
keymap.bind("<leader>sd"):to_lua_command(
    "vim.lsp.diagnostic.show_line_diagnostics()")
keymap.bind("<leader>gpd"):to_lua_command("vim.lsp.diagnostic.goto_prev()")
keymap.bind("<leader>gnd"):to_lua_command("vim.lsp.diagnostic.goto_next()")
keymap.bind("<leader>ll"):to_lua_command("vim.lsp.diagnostic.set_loclist()")
keymap.bind("<leader>fo"):to_lua_command("vim.lsp.buf.formatting()")
keymap.bind("<leader>sf"):in_mode('n'):to_command(":ClangdSwitchSourceHeader<CR>")

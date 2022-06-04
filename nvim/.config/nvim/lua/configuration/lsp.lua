local sumneko = require('configuration.sumneko')
local lspconfig = require('lspconfig')

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

-- LSP shortcuts
local options = { noremap=true, silent=true }

local print_workspace = function ()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end

vim.keymap.set("n", "gD", vim.lsp.buf.declaration, options)
vim.keymap.set("n", "gd", vim.lsp.buf.definition, options)
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, options)
vim.keymap.set("n", "gr", vim.lsp.buf.references, options)
vim.keymap.set("n", "gtd", vim.lsp.buf.type_definition, options)
vim.keymap.set("n", "K", vim.lsp.buf.hover, options)
vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, options)
vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, options)
vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, options)
vim.keymap.set("n", "<leader>wl", print_workspace, options)

vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, options)
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, options)
vim.keymap.set("n", "<leader>fo", vim.lsp.buf.formatting, options)
vim.keymap.set("n", "<leader>sf", ":ClangdSwitchSourceHeader<CR>", options)

vim.keymap.set("n", "gpd", vim.diagnostic.goto_prev, options)
vim.keymap.set("n", "gnd", vim.diagnostic.goto_next, options)
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, options)
vim.keymap.set("n", "<leader>sll", vim.diagnostic.setloclist, options)

local M = {}

M.setup = function(config)
    local has_lspconfig, lspconfig = pcall(require, 'lspconfig')
    if not has_lspconfig then
        return
    end

    lspconfig.sumneko_lua.setup({
        on_attach = config.on_attach,
        capabilities = config.capabilities,
        flags = config.lsp_flags,
        settings = {
            Lua = {
                runtime = { version = 'LuaJIT', path = vim.split(package.path, ';') },
                diagnostics = { globals = { 'vim' } },
                workspace = {
                    library = {
                        [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                        [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
                        [vim.fn.stdpath('config') .. "/lua"] = true
                    }
                }
            }
        }
    })
end

return M

local has_mason, mason = pcall(require, "mason")
if has_mason then
    mason.setup({
        automareq_installation = true,
        ui = {
            icons = {
                package_installed = "✓",
                package_pending = "➜",
                package_uninstalled = "✗"
            }
        }
    })
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = { "documentation", "detail", "additionalTextEdits" },
}

local has_cmp_lsp, cmp_lsp = pcall(require, 'cmp_nvim_lsp')
if has_cmp_lsp then
    capabilities = cmp_lsp.default_capabilities(capabilities)
end

local lsp_flags = {
    debounce_text_changes = 80,
}

local on_attach = function(_, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- LSP shortcuts
    local options = { noremap = true, silent = true, buffer = bufnr }

    local nmap = function(keys, func, desc)
        if desc then
            desc = 'LSP: ' .. desc
        end
        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    end

    local has_ts, ts = pcall(require, 'telescope.builtin')
    if has_ts then
        nmap("gd", ts.lsp_definitions, '[g]oto [d]efinition')
        nmap("gi", ts.lsp_implementations, '[g]oto [i]mplementatio')
        nmap("gr", ts.lsp_references, '[g]oto [r]eferences')
        nmap("gt", ts.lsp_type_definitions, '[g]oto [t]ype definitions')
        nmap("<leader>ds", ts.lsp_document_symbols, '[d]ocument [s]ymbols')
        nmap("<leader>ws", ts.lsp_dynamic_workspace_symbols, '[w]orkspace [s]ymbols')
    else
        nmap("gd", vim.lsp.buf.definition, '[g]oto [d]efinition')
        nmap("gi", vim.lsp.buf.implementation, '[g]oto [i]mplementatio')
        nmap("gr", vim.lsp.buf.references, '[g]oto [r]eferences')
        nmap("gt", vim.lsp.buf.type_definition, '[g]oto [t]ype definitions')
        nmap("<leader>ds", vim.lsp.buf.document_symbol, '[d]ocument [s]ymbols')
        nmap("<leader>ws", vim.lsp.buf.workspace_symbol, '[w]orkspace [s]ymbols')
    end

    nmap("K", vim.lsp.buf.hover, 'hover documentation')
    nmap("<C-k>", vim.lsp.buf.signature_help, 'signature help')
    nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, '[w]orkspace [a]dd folder')
    nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, '[w]orkspace [r]emove folder')
    nmap("<leader>rn", vim.lsp.buf.rename, '[r]e[n]ame')
    nmap("<leader>ca", vim.lsp.buf.code_action, '[c]ode [a]ction')
    nmap("<leader>clr", vim.lsp.codelens.refresh, '[c]ode[l]ens [r]efresh')
    nmap("<leader>cle", vim.lsp.codelens.run, '[c]ode[l]ens [e]xecute')
    nmap("<leader>fo", function() vim.lsp.buf.format({ async = true }) end, '[fo]rmat file')
    nmap("[d", vim.diagnostic.goto_prev, 'goto previous [d]iagnostic')
    nmap("]d", vim.diagnostic.goto_next, 'goto next [d]iagnostic')
    nmap("<leader>e", vim.diagnostic.open_float, 'open float')
    nmap("<leader>q", vim.diagnostic.setloclist, 'set local list')
end

local setup_servers = function(servers, config)
    for _, server in pairs(servers) do
        if type(server) == "table" then
            local has_server, current_server = pcall(require, server[1])
            if has_server then
                current_server[server[2]].setup(config)
            end
        else
            local _server = require(server)
            _server.setup(config)
        end
    end
end

-- use {module, function} or "module" to call server
local servers = {
    { "lspconfig", "bashls" },
    { "lspconfig", "angularls" },
    { "lspconfig", "vuels" },
    { "lspconfig", "eslint" },
    { "lspconfig", "tsserver" },
    { "lspconfig", "gopls" },
    { "lspconfig", "jedi_language_server" },
    { "lspconfig", "omnisharp" },
    { "lspconfig", "marksman" },
    { "lspconfig", "cmake" },
    { "lspconfig", "ltex" },
    "configuration.lsp.rust",
    "configuration.lsp.clangd",
    "configuration.lsp.lua",
    "configuration.lsp.null-lsp",
}

local config = {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = lsp_flags
}

setup_servers(servers, config)

local lsp_group = vim.api.nvim_create_augroup("LSPGroup", { clear = true })
vim.api.nvim_create_autocmd(
    { "BufWritePre" },
    {
        command = [[lua vim.lsp.buf.format({async = false})]],
        group = lsp_group
    }
)

vim.api.nvim_create_autocmd(
    { "CursorHold", "CursorHoldI" },
    {
        command = [[lua vim.diagnostic.open_float(nil, {focus=false})]],
        group = lsp_group
    }
)

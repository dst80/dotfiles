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

    local has_ts, ts = pcall(require, 'telescope.builtin')
    if has_ts then
        vim.keymap.set("n", "gd", ts.lsp_definitions, options)
        vim.keymap.set("n", "gi", ts.lsp_implementations, options)
        vim.keymap.set("n", "gr", ts.lsp_references, options)
        vim.keymap.set("n", "gt", ts.lsp_type_definitions, options)
    else
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, options)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, options)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, options)
        vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, options)
    end

    vim.keymap.set("n", "K", vim.lsp.buf.hover, options)
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, options)
    vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, options)
    vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, options)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, options)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, options)
    vim.keymap.set("n", "<leader>cr", vim.lsp.codelens.refresh, options)
    vim.keymap.set("n", "<leader>ce", vim.lsp.codelens.run, options)
    vim.keymap.set("n", "<leader>fo", function() vim.lsp.buf.format({ async = true }) end, options)
    vim.keymap.set("n", "<leader>bd", vim.diagnostic.goto_prev, options)
    vim.keymap.set("n", "<leader>nd", vim.diagnostic.goto_next, options)
    vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, options)
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
    })

vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
    command = [[lua vim.diagnostic.open_float(nil, {focus=false})]],
    group = lsp_group
})

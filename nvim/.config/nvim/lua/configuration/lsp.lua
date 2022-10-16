require("mason").setup({
    automareq_installation = true,
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

local lspconfig = require('lspconfig')
local util = require('lspconfig/util')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

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
    vim.keymap.set("n", "<leader>db", vim.diagnostic.goto_prev, options)
    vim.keymap.set("n", "<leader>dn", vim.diagnostic.goto_next, options)
    vim.keymap.set("n", "<leader>sll", vim.diagnostic.setloclist, options)
end

lspconfig.bashls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = lsp_flags,
}

lspconfig.angularls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = lsp_flags,
}

lspconfig.vuels.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = lsp_flags,
}

lspconfig.eslint.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = lsp_flags,
}

lspconfig.tsserver.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = lsp_flags,
}

lspconfig.gopls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = lsp_flags,
}

lspconfig.jedi_language_server.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = lsp_flags,
}

lspconfig.omnisharp.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = lsp_flags,
}

lspconfig.marksman.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = lsp_flags,
}

lspconfig.cmake.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = lsp_flags,
}

lspconfig.sumneko_lua.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = lsp_flags,
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
}

local server_settings = {
    on_attach = function(_, bufnr)
        on_attach(_, bufnr)
        local options = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set("n", "<leader>sf", ":ClangdSwitchSourceHeader<CR>", options)
    end,
    capabilities = capabilities,
    flags = lsp_flags,
    filetypes = {
        "c", "cc", "cpp", "cxx", "h", "hpp", "hxx", "objc", "objcc"
    },
    root_dir = util.root_pattern(
        ".clangd",
        ".clang-tidy",
        ".clang-format",
        "compile_commands.json",
        "compile_flags.txt",
        "configure.ac",
        ".git") or vim.loop.os_homedir(),
    single_file_support = true,
}

local has_ext_clang, ext_clang = pcall(require("clangd_extensions"))
if has_ext_clang then
    ext_clang.setup {
        server = server_settings,
    }
else
    lspconfig.clangd.setup(server_settings)
end

lspconfig.rust_analyzer.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    flags = lsp_flags,
    settings = {
        ["rust_analyzer"] = {
            cargo = { allFreatures = true },
            checkOnSave = { allFreatures = true, command = "clippy" },
        }
    }
})

local lsp_group = vim.api.nvim_create_augroup("LSPGroup", { clear = true })
vim.api.nvim_create_autocmd(
    { "BufWritePre" },
    {
        command = [[lua vim.lsp.buf.format({async = false})]],
        group = lsp_group
    })

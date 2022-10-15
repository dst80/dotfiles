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

local on_attach = function(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- LSP shortcuts
    local options = { noremap = true, silent = true, buffer = 0 }
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, options)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, options)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, options)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, options)
    vim.keymap.set("n", "gtd", vim.lsp.buf.type_definition, options)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, options)
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, options)
    vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, options)
    vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, options)
    vim.keymap.set("n", "<leader>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, options)

    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, options)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, options)
    vim.keymap.set("n", "<leader>fo", function() vim.lsp.buf.format({ async = true }) end, options)
    vim.keymap.set("n", "<leader>db", vim.diagnostic.goto_prev, options)
    vim.keymap.set("n", "<leader>dn", vim.diagnostic.goto_next, options)
    vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, options)
    vim.keymap.set("n", "<leader>sll", vim.diagnostic.setloclist, options)
end

lspconfig.bashls.setup {
    on_attach = on_attach,
    capabilities = capabilities
}

lspconfig.angularls.setup {
    on_attach = on_attach,
    capabilities = capabilities
}

lspconfig.vuels.setup {
    on_attach = on_attach,
    capabilities = capabilities
}

lspconfig.eslint.setup {
    on_attach = on_attach,
    capabilities = capabilities
}

lspconfig.tsserver.setup {
    on_attach = on_attach,
    capabilities = capabilities
}

lspconfig.gopls.setup {
    on_attach = on_attach,
    capabilities = capabilities
}

lspconfig.rust_analyzer.setup {
    on_attach = on_attach,
    capabilities = capabilities
}

lspconfig.jedi_language_server.setup {
    on_attach = on_attach,
    capabilities = capabilities
}

lspconfig.omnisharp.setup {
    on_attach = on_attach,
    capabilities = capabilities
}

lspconfig.marksman.setup {
    on_attach = on_attach,
    capabilities = capabilities
}

lspconfig.cmake.setup {
    on_attach = on_attach,
    capabilities = capabilities
}

lspconfig.sumneko_lua.setup {
    on_attach = on_attach,
    capabilities = capabilities,
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
    on_attach = function(client, bufnr)
        on_attach(client, bufnr)
        local options = { noremap = true, silent = true, buffer = 0 }
        vim.keymap.set("n", "<leader>sf", ":ClangdSwitchSourceHeader<CR>", options)
    end,
    capabilities = capabilities,
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

if not pcall(require, 'clangd_extensions') then
    lspconfig.clangd.setup(server_settings)
else
    require("clangd_extensions").setup {
        server = server_settings,
        extensions = {
            autoSetHints = true,
            hover_with_actions = true,
            inlay_hints = {
                only_current_line = false,
                only_current_line_autocmd = "CursorHold",
                show_parameter_hints = true,
                parameter_hints_prefix = "<- ",
                other_hints_prefix = "=> ",
                max_len_align = false,
                max_len_align_padding = 1,
                right_align = false,
                right_align_padding = 7,
                highlight = "Comment",
            },
            ast = {
                role_icons = {
                    type = "",
                    declaration = "",
                    expression = "",
                    specifier = "",
                    statement = "",
                    ["template argument"] = "",
                },

                kind_icons = {
                    Compound = "",
                    Recovery = "",
                    TranslationUnit = "",
                    PackExpansion = "",
                    TemplateTypeParm = "",
                    TemplateTemplateParm = "",
                    TemplateParamObject = "",
                },

                highlights = {
                    detail = "Comment",
                },
                memory_usage = {
                    border = "none",
                },
                symbol_info = {
                    border = "none",
                },
            },
        }
    }
end

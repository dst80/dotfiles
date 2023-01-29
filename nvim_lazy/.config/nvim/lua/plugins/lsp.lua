local M = {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "j-hui/fidget.nvim",
        "folke/neodev.nvim",
    },
    lazy = true,
    event = "BufReadPost",
}

function M.config()
    local on_attach = function(_, bufnr)
        vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

        local options = { noremap = true, silent = true, buffer = bufnr }

        local nmap = function(keys, func, desc)
            if desc then
                desc = "LSP: " .. desc
            end
            vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
        end

        local has_ts, ts = pcall(require, "telescope.builtin")
        if has_ts then
            nmap("gd", ts.lsp_definitions, "[g]oto [d]efinition")
            nmap("gi", ts.lsp_implementations, "[g]oto [i]mplementatio")
            nmap("gr", ts.lsp_references, "[g]oto [r]eferences")
            nmap("gt", ts.lsp_type_definitions, "[g]oto [t]ype definitions")
            nmap("<leader>ds", ts.lsp_document_symbols, "[d]ocument [s]ymbols")
            nmap("<leader>ws", ts.lsp_dynamic_workspace_symbols, "[w]orkspace [s]ymbols")
        else

            nmap("gd", vim.lsp.buf.definition, "[g]oto [d]efinition")
            nmap("gi", vim.lsp.buf.implementation, "[g]oto [i]mplementation")
            nmap("gr", vim.lsp.buf.references, "[g]oto [r]eferences")
            nmap("gt", vim.lsp.buf.type_definition, "[g]oto [t]ype definitions")
            nmap("<leader>ds", vim.lsp.buf.document_symbol, "[d]ocument [s]ymbols")
            nmap("<leader>ws", vim.lsp.buf.workspace_symbol, "[w]orkspace [s]ymbols")
        end

        nmap("K", vim.lsp.buf.hover, "hover documentation")
        nmap("<C-k>", vim.lsp.buf.signature_help, "signature help")
        nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[w]orkspace [a]dd folder")
        nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[w]orkspace [r]emove folder")
        nmap("<leader>rn", vim.lsp.buf.rename, "[r]e[n]ame")
        nmap("<leader>ca", vim.lsp.buf.code_action, "[c]ode [a]ction")
        nmap("<leader>clr", vim.lsp.codelens.refresh, "[c]ode[l]ens [r]efresh")
        nmap("<leader>cle", vim.lsp.codelens.run, "[c]ode[l]ens [e]xecute")
        nmap("<leader>fo", function()
            vim.lsp.buf.format({ async = true })
        end, "[fo]rmat file")
        nmap("[d", vim.diagnostic.goto_prev, "goto previous [d]iagnostic")
        nmap("]d", vim.diagnostic.goto_next, "goto next [d]iagnostic")
        nmap("<leader>e", vim.diagnostic.open_float, "open float")
        nmap("<leader>q", vim.diagnostic.setloclist, "set local list")
    end

    local servers = {
        clangd = {
            filetypes = {
                "c",
                "cc",
                "cpp",
                "cxx",
                "h",
                "hpp",
                "hxx",
                "objc",
                "objcc",
            },
            single_file_support = true,
            init_options = {
                clangdFileStatus = true,
                usePlaceholders = true,
                completeUnimported = true,
                semanticHighlighting = true,
            },
        },
        gopls = {},
        jedi_language_server = {},
        rust_analyzer = {
            settings = {
                ["rust_analyzer"] = {
                    cargo = { allFreatures = true },
                    checkOnSave = { allFreatures = true, command = "clippy" },
                    completion = { postfix = { enable = false } },
                },
            },
        },
        tsserver = {},

        sumneko_lua = {
            Lua = {
                workspace = { checkThirdParty = false },
                telemetry = { enable = false },
            },
        },
    }

    require("neodev").setup()
    --
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

    require("mason").setup()

    local mason_lspconfig = require("mason-lspconfig")

    mason_lspconfig.setup({
        ensure_installed = vim.tbl_keys(servers),
    })

    mason_lspconfig.setup_handlers({
        function(server_name)
            require("lspconfig")[server_name].setup({
                capabilities = capabilities,
                on_attach = on_attach,
                settings = servers[server_name],
            })
        end,
    })

    require("fidget").setup({
        text = {
            spinner = "dots",
            commenced = "",
            compleded = "",
        },
    })

    local lsp_group = vim.api.nvim_create_augroup("LSPGroup", { clear = true })
    vim.api.nvim_create_autocmd({ "BufWritePre" }, {
        command = [[lua vim.lsp.buf.format({async = false})]],
        group = lsp_group,
    })

    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        command = [[lua vim.diagnostic.open_float(nil, {focus=false})]],
        group = lsp_group,
    })
end

return M

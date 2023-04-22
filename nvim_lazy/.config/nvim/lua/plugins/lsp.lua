local M = {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "j-hui/fidget.nvim",
        "folke/neodev.nvim",
        "simrat39/rust-tools.nvim",
        "p00f/clangd_extensions.nvim",
    },
    lazy = true,
    cmd = "Mason",
    event = "BufReadPost",
}

function M.config()
    local on_attach = function(_, bufnr)
        vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
        require("lsp_keymap").set_lsp_keymap(bufnr)
    end

    local servers = {
        angularls = {},
        clangd = {
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
        neocmake = {},
        marksman = {},
        omnisharp = {},
        rust_analyzer = {
            settings = {
                ["rust_analyzer"] = {
                    cargo = { allFreatures = true },
                    checkOnSave = { allFreatures = true, command = "clippy" },
                    completion = { postfix = { enable = false } },
                },
            },
        },
        taplo = {},
        tsserver = {},
        lua_ls = {
            Lua = {
                workspace = { checkThirdParty = false },
                telemetry = { enable = false },
            },
        },
        volar = {},
        wgsl_analyzer = {},
    }

    -- not supported under windows
    if (string.find(vim.loop.os_uname().sysname, "Windows") == nil) then
        servers.bashls = {}
    end

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
        ["rust_analyzer"] = function()
            local rt = require("rust-tools")
            rt.setup {
                tools = {
                    inlay_hints = {
                        auto = true,
                        only_current_line = true,
                        show_parameter_hints = true,
                    },
                    executor = require("rust-tools/executors").toggleterm,
                    hover_actions = {
                        border = "none",
                        auto_focus = true
                    },
                },
                server = {
                    on_attach = function(_, bufnr)
                        on_attach(_, bufnr)
                        vim.keymap.set("n", "<leader>rf", rt.hover_actions.hover_actions, { buffer = bufnr })
                    end,
                },
                dap = {
                    adapter = {
                        type = "executable",
                        command = "lldb-vscode",
                        name = "rt_lldb",
                    },
                },
            }
        end,
        ["clangd"] = function()
            require("clangd_extensions").setup({
                server = {
                    on_attach = function(_, bufnr)
                        on_attach(_, bufnr)
                    end,
                },
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
        command = [[lua vim.diagnostic.open_float(nil, {focus=false, scope='cursor'})]],
        group = lsp_group,
    })
end

return M

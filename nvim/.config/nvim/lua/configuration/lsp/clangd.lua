local M = {}

local lspconfig = require('lspconfig')
local util = require('lspconfig/util')

M.setup = function(config)
    local clangd_capabilities = config.capabilities
    clangd_capabilities.textDocument.semanHighlighting = true
    clangd_capabilities.offsetEncoding = "utf-8"

    local server_settings = {
        on_attach = function(_, bufnr)
            config.on_attach(_, bufnr)
            local options = {
                noremap = true,
                silent = true,
                buffer = bufnr,
                desc   = '[s]witch [s]source [h]eader'
            }
            vim.keymap.set(
                "n", "<leader>sf", ":ClangdSwitchSourceHeader<CR>", options)
        end,
        capabilities = clangd_capabilities,
        flags = config.lsp_flags,
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

        init_options = {
            clangdFileStatus = true,
            usePlaceholders = true,
            completeUnimported = true,
            semanticHighlighting = true,
        }
    }

    local has_ext_clang, ext_clang = pcall(require("clangd_extensions"))
    if has_ext_clang then
        ext_clang.setup {
            server = server_settings,
        }
    else
        lspconfig.clangd.setup(server_settings)
    end
end

return M

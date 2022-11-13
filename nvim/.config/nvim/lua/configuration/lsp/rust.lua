local M = {}
local lspconfig = require('lspconfig')

M.setup = function(config)
    local has_rust_tools, rt = pcall(require, 'rust_tools')
    if has_rust_tools then
        rt.setup({
            tools = {
                inlay_hints = {
                    auto = true,
                    only_current_line = true,
                    show_parameter_hints = true,
                },
                hover_actions = {
                    border = {
                        { "", "FloatBorder" },
                        { "", "FloatBorder" },
                        { "", "FloatBorder" },
                        { "", "FloatBorder" },
                        { "", "FloatBorder" },
                        { "", "FloatBorder" },
                        { "", "FloatBorder" },
                        { "", "FloatBorder" },
                    },
                    auto_focus = true
                }
            },
            server = {
                on_attach = function(_, bufnr)
                    config.on_attach(_, bufnr)
                    vim.keymap.set("n", "<leader>rf", rt.hover_actions.hover_actions, { buffer = bufnr })
                end,
                settings = {
                    ["rust_analyzer"] = {
                        cargo = { allFreatures = true },
                        checkOnSave = { allFreatures = true, command = "clippy" },
                        completion = { postfix = { enable = false, }, },
                    }
                }
            }
        })
    else
        lspconfig.rust_analyzer.setup({
            on_attach = config.on_attach,
            capabilities = config.capabilities,
            flags = config.lsp_flags,
            settings = {
                ["rust_analyzer"] = {
                    cargo = { allFreatures = true },
                    checkOnSave = { allFreatures = true, command = "clippy" },
                    completion = { postfix = { enable = false, }, },
                }
            }
        })
    end
end

return M

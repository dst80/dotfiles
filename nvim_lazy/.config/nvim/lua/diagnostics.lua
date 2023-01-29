local M = {}



function M.setup()

    local signs = {
        Error = "",
        Warn = " ",
        Hint = "",
        Information = ""
    }

    for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end

    local config = {
        virtual_text = {
            severity = "ERROR",
            spacing = 2,
            prefix = "<=",
        },
        -- show signs
        signs = {
            active = signs,
        },
        update_in_insert = true,
        underline = true,
        severity_sort = true,
        float = {
            focusable = false,
            style = "minimal",
            border = "none",
            source = "always",
            severity = { max = "WARN" },
            header = "",
            prefix = "",
        },
    }

    vim.diagnostic.config(config)
    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "rounded",
        width = 60,
    })
    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = "rounded",
        width = 60,
    })

end

return M

local M = {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = {
        "jay-babu/mason-null-ls.nvim",
        "nvim-lua/plenary.nvim",
    },
    lazy = true,
    event = "BufReadPost",
}

local attach = function(_, bufnr)
    local function do_rename(win)
        local new_name = vim.trim(vim.fn.getline("."))
        vim.api.nvim_win_close(win, true)
        vim.lsp.buf.rename(new_name)
    end

    local function rename()
        local cursor_word = vim.fn.expand('<cword>')
        local opts = {
            relative = 'cursor',
            row = 0,
            col = 0,
            width = string.len(cursor_word) + 20,
            height = 1,
            style = 'minimal',
            border = 'rounded',
        }
        local buf = vim.api.nvim_create_buf(false, true)
        local win = vim.api.nvim_open_win(buf, true, opts)

        vim.api.nvim_buf_set_lines(buf, 0, -1, false, { cursor_word })
        vim.keymap.set({ 'i', 'n' }, '<CR>', function() do_rename(win) end, { silent = true, buffer = buf })
        vim.keymap.set('n', '<ESC>', '<cmd>:q<CR>', { silent = true, buffer = buf })
    end

    local n_map = function(keys, func, desc)
        if desc then
            desc = "LSP: " .. desc
        end
        vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
    end
    local has_ts, ts = pcall(require, "telescope.builtin")
    if has_ts then
        n_map("gd", ts.lsp_definitions, "[g]oto [d]efinition")
        n_map("gi", ts.lsp_implementations, "[g]oto [i]mplementation")
        n_map("gr", ts.lsp_references, "[g]oto [r]eferences")
        n_map("gt", ts.lsp_type_definitions, "[g]oto [t]ype definitions")
        n_map("<leader>ds", ts.lsp_document_symbols, "[d]ocument [s]ymbols")
        n_map("<leader>ws", ts.lsp_dynamic_workspace_symbols, "[w]orkspace [s]ymbols")
    else
        n_map("gd", vim.lsp.buf.definition, "[g]oto [d]efinition")
        n_map("gi", vim.lsp.buf.implementation, "[g]oto [i]mplementation")
        n_map("gr", vim.lsp.buf.references, "[g]oto [r]eferences")
        n_map("gt", vim.lsp.buf.type_definition, "[g]oto [t]ype definitions")
        n_map("<leader>ds", vim.lsp.buf.document_symbol, "[d]ocument [s]ymbols")
        n_map("<leader>ws", vim.lsp.buf.workspace_symbol, "[w]orkspace [s]ymbols")
    end

    n_map("K", vim.lsp.buf.hover, "hover documentation")
    n_map("<C-k>", vim.lsp.buf.signature_help, "signature help")
    n_map("<leader>wa", vim.lsp.buf.add_workspace_folder, "[w]orkspace [a]dd folder")
    n_map("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[w]orkspace [r]emove folder")
    n_map("<leader>rn", rename, "[r]e[n]ame")
    n_map("<leader>ca", vim.lsp.buf.code_action, "[c]ode [a]ction")
    n_map("<leader>cr", vim.lsp.codelens.refresh, "[c]odelens [r]efresh")
    n_map("<leader>ce", vim.lsp.codelens.run, "[c]odelens [e]xecute")
    n_map("<leader>fo", function()
        vim.lsp.buf.format({ async = true })
    end, "[fo]rmat file")
    n_map("[d", vim.diagnostic.goto_prev, "goto previous [d]iagnostic")
    n_map("]d", vim.diagnostic.goto_next, "goto next [d]iagnostic")
    n_map("<leader>e", vim.diagnostic.open_float, "open float")
    n_map("<leader>q", vim.diagnostic.setloclist, "set local list")
end

local diagnostics_postprocess = function(diagnostic)
    diagnostic.severity = vim.diagnostic.severity.INFO
end

function M.config()
    local null_ls = require("null-ls")
    null_ls.setup({
        debug = false,
        on_attach = attach,
        sources = {
            null_ls.builtins.code_actions.cspell,
            null_ls.builtins.diagnostics.cspell.with({
                diagnostics_postprocess = diagnostics_postprocess
            }),
            null_ls.builtins.formatting.stylua,
            null_ls.builtins.formatting.beautysh,
            null_ls.builtins.formatting.rome,
            null_ls.builtins.formatting.prettier,
            null_ls.builtins.formatting.cmake_format,
            null_ls.builtins.formatting.clang_format,
        },
    })
    local mason_null_ls = require("mason-null-ls")
    mason_null_ls.setup({
        automatic_installation = true,
        automatic_setup = false,
    })
end

return M

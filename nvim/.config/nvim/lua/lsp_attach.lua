local M = {}

function M.rename(window)
    local new_name = vim.trim(vim.fn.getline("."))
    vim.api.nvim_win_close(window, true)
    vim.lsp.buf.rename(new_name)
end

function M.open_rename_dialog()
    local cursor_word = vim.fn.expand('<cword>')
    local options = {
        relative = 'cursor',
        row = 0,
        col = 0,
        width = string.len(cursor_word) + 20,
        height = 1,
        style = 'minimal',
        border = "single",
        zindex = 100,
        title = "Rename",
        title_pos = "left",
    }
    local buffer = vim.api.nvim_create_buf(false, true)
    local window = vim.api.nvim_open_win(buffer, true, options)

    vim.api.nvim_buf_set_lines(buffer, 0, -1, false, { cursor_word })
    vim.keymap.set({ 'i', 'n' }, '<CR>', function() M.rename(window) end, { silent = true, buffer = buffer })
    vim.keymap.set('n', '<ESC>', '<cmd>:q<CR>', { silent = true, buffer = buffer })
    vim.keymap.set('n', 'q', '<cmd>:q<CR>', { silent = true, buffer = buffer })
end

function M.format_file()
    vim.lsp.buf.format({ async = true })
end

function M.attach(buffer)
    local keymap = require("plugin_keymaps")
    local has_ts, ts = pcall(require, "telescope.builtin")
    if has_ts then
        keymap.map_for_buffer("n", keymap.list.edit_goto_definitions, ts.lsp_definitions, buffer)
        keymap.map_for_buffer("n", keymap.list.edit_goto_implementations, ts.lsp_implementations, buffer)
        keymap.map_for_buffer("n", keymap.list.edit_goto_references, ts.lsp_references, buffer)
        keymap.map_for_buffer("n", keymap.list.edit_goto_type_definitions, ts.lsp_type_definitions, buffer)
        keymap.map_for_buffer("n", keymap.list.edit_document_symbols, ts.lsp_document_symbols, buffer)
        keymap.map_for_buffer("n", keymap.list.edit_workspace_symbols, ts.lsp_dynamic_workspace_symbols, buffer)
    else
        keymap.map_for_buffer("n", keymap.list.edit_goto_definitions, vim.lsp.buf.definition, buffer)
        keymap.map_for_buffer("n", keymap.list.edit_goto_implementations, vim.lsp.buf.implementation, buffer)
        keymap.map_for_buffer("n", keymap.list.edit_goto_references, vim.lsp.buf.references, buffer)
        keymap.map_for_buffer("n", keymap.list.edit_goto_type_definitions, vim.lsp.buf.type_definition, buffer)
        keymap.map_for_buffer("n", keymap.list.edit_document_symbols, vim.lsp.buf.document_symbol, buffer)
        keymap.map_for_buffer("n", keymap.list.edit_workspace_symbols, vim.lsp.buf.workspace_symbol, buffer)
    end

    keymap.map_for_buffer("n", keymap.list.edit_hover_documentation, vim.lsp.buf.hover, buffer)
    keymap.map_for_buffer("n", keymap.list.edit_signature_help, vim.lsp.buf.signature_help, buffer)
    keymap.map_for_buffer("n", keymap.list.edit_add_workspace_folder, vim.lsp.buf.add_workspace_folder, buffer)
    keymap.map_for_buffer("n", keymap.list.edit_remove_workspace_folder, vim.lsp.buf.remove_workspace_folder, buffer)
    keymap.map_for_buffer("n", keymap.list.edit_rename, M.open_rename_dialog, buffer)
    keymap.map_for_buffer("n", keymap.list.edit_code_action, vim.lsp.buf.code_action, buffer)
    keymap.map_for_buffer("n", keymap.list.edit_codelens_refresh, vim.lsp.codelens.refresh, buffer)
    keymap.map_for_buffer("n", keymap.list.edit_codelens_execute, vim.lsp.codelens.run, buffer)
    keymap.map_for_buffer("n", keymap.list.edit_format_file, M.format_file, buffer)
    keymap.map_for_buffer("n", keymap.list.edit_goto_previous_diagnostic, vim.diagnostic.goto_prev, buffer)
    keymap.map_for_buffer("n", keymap.list.edit_goto_next_diagnostic, vim.diagnostic.goto_next, buffer)
    keymap.map_for_buffer("n", keymap.list.edit_open_diagnostic_preview, vim.diagnostic.open_float, buffer)
    keymap.map_for_buffer("n", keymap.list.edit_show_local_list, vim.diagnostic.setloclist, buffer)
end

return M

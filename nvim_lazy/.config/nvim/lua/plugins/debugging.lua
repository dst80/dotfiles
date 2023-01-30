local M = {
    "mfussenegger/nvim-dap",
    dependencies = {
        { "theHamsta/nvim-dap-virtual-text" },
        { "nvim-telescope/telescope.nvim" },
        { "nvim-telescope/telescope-dap.nvim" },
    },
    lazy = true,
    filetype = { "c", "cpp", "rust", "python", "javascript", "java" }
}

function M.config()
    local has_dap, dap = pcall(require, 'dap')
    if not has_dap then
        return
    end


    local function get_lldb_path()
        return '/usr/bin/lldb-vscode'
    end

    dap.adapters.lldb = {
        type = 'executable',
        command = get_lldb_path(),
        name = 'lldb'
    }

    dap.configurations.cpp = {
        {
            name = 'Launch',
            type = 'lldb',
            request = 'launch',
            program = function()
                return vim.fn.input(
                    'Path to executable: ', vim.fn.getcwd() .. '/', 'file')
            end,
            cwd = '${workspaceFolder}',
            stopOnEntry = false,
            args = {},
        }
    }

    dap.configurations.c = dap.configurations.cpp
    dap.configurations.rust = dap.configurations.cpp

    -- python
    dap.configurations.python = {
        name = "Launch file",
        type = 'python',
        request = 'launch',
        program = "${file}",
        pythonPath = function()
            local cwd = vim.fn.getcwd()
            if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
                return cwd .. '/venv/bin/python'
            elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
                return cwd .. '/.venv/bin/python'
            else
                return '/usr/bin/python'
            end
        end
    }

    local options = { noremap = true }
    vim.keymap.set("n", "<F5>", dap.continue, options)
    vim.keymap.set("n", "<F9>", dap.step_back, options)
    vim.keymap.set("n", "<F10>", dap.step_over, options)
    vim.keymap.set("n", "<F11>", dap.step_into, options)
    vim.keymap.set("n", "<F12>", dap.step_out, options)
    vim.keymap.set("n", "<Leader>tb", dap.toggle_breakpoint, options)
    vim.keymap.set("n", "<Leader>scb", function()
        dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
    end, options)
    vim.keymap.set("n", "<Leader>dr", dap.repl.open, options)
    vim.keymap.set("n", "<Leader>dl", dap.run_last, options)
    vim.keymap.set({ 'n', 'v' }, '<Leader>dbh', function()
        require('dap.ui.widgets').hover()
    end, { desc = "[d]e[b]ug [h]overs" })
    vim.keymap.set({ 'n', 'v' }, '<Leader>dbp', function()
        require('dap.ui.widgets').preview()
    end, { desc = "[d]e[b]ug [p]reviews" })
    vim.keymap.set('n', '<Leader>dbf', function()
        local widgets = require('dap.ui.widgets')
        widgets.centered_float(widgets.frames)
    end, { desc = "[d]e[b]ug [f]rames" })
    vim.keymap.set('n', '<Leader>dbs', function()
        local widgets = require('dap.ui.widgets')
        widgets.centered_float(widgets.scopes)
    end, { desc = "[d]e[b]ug [s]copes" })

    vim.fn.sign_define("DapBreakpoint", { text = " ", texthl = "error", linehl = "", numhl = "" })
    vim.fn.sign_define("DapBreakpointCondition", { text = " ", texthl = "error", linehl = "", numhl = "" })
    vim.fn.sign_define("DapBreakpointRejected", { text = " ", texthl = "error", linehl = "", numhl = "" })
    vim.fn.sign_define("DapLogPoint", { text = " ", texthl = "warning", linehl = "", numhl = "" })

    -- not working :(
    -- local dap_group = vim.api.nvim_create_augroup('DapRepl', { clean = true })
    -- vim.api.nvim_create_autocmd("FileType", {
    --     group = dap_group,
    --     pattern = { 'dap-repl' },
    --     callback = function() require('dap.ext.autocompl').attach() end
    -- })


    local has_dap_vt, dap_vt = pcall(require, 'nvim-dap-virtual-text')
    if has_dap_vt then
        dap_vt.setup({
            enabled_commands = true,
            highlight_changed_variables = true,
            highlight_new_as_changed = false,
            show_stop_reason = true,
            commented = false,
            only_first_definition = true,
            all_references = false,
            filter_references_pattern = '<module',
            virt_text_pos = 'eol',
            all_frames = false,
            virt_lines = false,
            virt_text_win_col = nil,
        })
    end

    require('telescope').load_extension('dap')
    vim.keymap.set('n', '<Leader>dbb', require 'telescope'.extensions.dap.list_breakpoints,
        { desc = "[d]e[b]ug [b]reakpoints" })
    vim.keymap.set('n', '<Leader>dbc', require 'telescope'.extensions.dap.commands, { desc = "[d]e[b]ug [c]ommands" })
    vim.keymap.set('n', '<Leader>dbp', require 'telescope'.extensions.dap.variables, { desc = "[d]e[b]ug [p]reviews" })
    vim.keymap.set('n', '<Leader>dbf', require 'telescope'.extensions.dap.frames, { desc = "[d]e[b]ug [f]rames" })
end

return M

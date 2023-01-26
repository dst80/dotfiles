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

local options = { noremap = true, silent = true }
vim.keymap.set("n", "<F5>", dap.continue, options)
vim.keymap.set("n", "<F9>", dap.step_back, options)
vim.keymap.set("n", "<F10>", dap.step_over, options)
vim.keymap.set("n", "<F11>", dap.step_into, options)
vim.keymap.set("n", "<F12>", dap.step_out, options)
vim.keymap.set("n", "<Leader>tb", dap.toggle_breakpoint, options)
vim.keymap.set("n", "<Leader>cb", function()
    dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
end, options)
vim.keymap.set("n", "<Leader>dr", dap.repl.open, options)
vim.keymap.set("n", "<Leader>dl", dap.run_last, options)


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

local has_dapui, dapui = pcall(require, 'dapui')
if not has_dapui then
    return
end

dapui.setup({
    layouts = {
        {
            elements = {
                "scopes",
                "breakpoints",
                "stacks",
                "watches",
            },
            size = 80,
            position = "left",
        },
        {
            elements = { "repl", "console" },
            size = 0.25,
            position = "bottom",
        },
    },
    render = {
        max_value_lines = 3,
    },
    floating = { max_width = 0.9, max_height = 0.5, border = vim.g.border_chars },
})

dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
end

vim.keymap.set("n", "<Leader>de", dapui.eval, options)
vim.keymap.set("n", "<Leader>dE", function()
    dapui.eval(vim.fn.input("[DAP] expression >"))
end, options)

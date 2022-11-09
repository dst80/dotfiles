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
vim.keymap.set("n", "<Leader>db", dap.toggle_breakpoint, options)
vim.keymap.set("n", "<Leader>dB", function()
    dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
end, options)
vim.keymap.set("n", "<Leader>dr", dap.repl.open, options)
vim.keymap.set("n", "<Leader>dl", dap.run_last, options)


-- not working :(
-- local dap_group = vim.api.nvim_create_augroup('DapRepl', { clean = true })
-- vim.api.nvim_create_autocmd("FileType", {
--     group = dap_group,
--     pattern = { 'dap-repl' },
--     callback = function() require('dap.ext.autocompl').attach() end
-- })

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
            size = 40,
            position = "left",
        },
        {
            elements = {
                "repl",
                "console",
            },
            size = 10,
            position = "bottom",
        },
    },
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
local dap = require('dap')

--  c languages

dap.adapters.lldb = {
    type = 'executable',
    command = '/usr/bin/lldb-vscode',
    name = "lldb"
}

dap.configurations.cpp = {
    {
        name = "Launch",
        type = "lldb",
        request = "launch",
        program = function ()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd () .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = {},
        runInTerminal = false,
    },
    {
        name = "Attach by name",
        type = "lldb",
        request = "attach",
        program = function ()
            return vim.fn.input('Program name to attach', vim.fn.getcwd ())
        end,
    },
    {
        name = "Attach by PID",
        type = "lldb",
        request = "attach",
        program = function ()
            return vim.fn.input('Program name to attach', vim.fn.getcwd ())
        end,
        pid = function ()
            return vim.fn.input('Programs PID', vim.fn.getcwd ())
        end
    }
}

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp


-- python

dap.adapters.python = {
    type = 'executable',
    command ='/home/dennis/VirtualEnv/bin/python',
    args = {'-m', 'debugpy.adapter'}
}

dap.configurations.python = {
    name = "Launch file",
    type = 'python',
    request = 'launch',
    program = "${file}",
    pythonPath = function()
        local cwd = vim.fn.getcwd ()
        if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
            return cwd .. '/venv/bin/python'
        elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
            return cwd .. '/.venv/bin/python'
        else
            return '/usr/bin/python'
        end
    end
}

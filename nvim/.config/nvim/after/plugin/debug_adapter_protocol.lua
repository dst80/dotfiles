local dap = require('dap')

dap.configurations.cpp = {
    {
        name = "Launch",
        type = "lldb",
        request = "launch",
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
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
        program = function()
            return vim.fn.input('Program name to attach', vim.fn.getcwd())
        end,
    },
    {
        name = "Attach by PID",
        type = "lldb",
        request = "attach",
        program = function()
            return vim.fn.input('Program name to attach', vim.fn.getcwd())
        end,
        pid = function()
            return vim.fn.input('Programs PID', vim.fn.getcwd())
        end
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

require("dapui").setup({
    icons = { expanded = "▾", collapsed = "▸" },
    mappings = {
        -- Use a table to apply multiple mappings
        expand = { "<CR>", "<2-LeftMouse>" },
        open = "o",
        remove = "d",
        edit = "e",
        repl = "r",
        toggle = "t",
    },
    -- Expand lines larger than the window
    -- Requires >= 0.7
    expand_lines = vim.fn.has("nvim-0.7"),
    layouts = {
        {
            elements = {
                'scopes',
                'breakpoints',
                'stacks',
                'watches',
            },
            size = 40,
            position = 'left',
        },
        {
            elements = {
                'repl',
                'console',
            },
            size = 10,
            position = 'bottom',
        },
     },
     floating = {
        max_height = nil, -- These can be integers or a float between 0 and 1.
        max_width = nil, -- Floats will be treated as percentage of your screen.
        border = "single", -- Border style. Can be "single", "double" or "rounded"
        mappings = {
            close = { "q", "<Esc>" },
        },
    },
    windows = { indent = 1 },
    render = {
        max_type_length = nil, -- Can be integer or nil.
    }
})

local options = {noremap = true, silent = true}

vim.keymap.set("n", "<F5>", "<Cmd>lua require'dap'.continue()<CR>", options)
vim.keymap.set("n", "<F10>", "<Cmd>lua require'dap'.step_over()<CR>", options)
vim.keymap.set("n", "<F11>", "<Cmd>lua require'dap'.step_into()<CR>", options)
vim.keymap.set("n", "<F12>", "<Cmd>lua require'dap'.step_out()<CR>", options)
vim.keymap.set("n", "<Leader>b", "<Cmd>lua require'dap'.toggle_breakpoint()<CR>", options)
vim.keymap.set("n", "<Leader>B", "<Cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", options)
vim.keymap.set("n", "<Leader>lp", "<Cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>", options)
vim.keymap.set("n", "<Leader>dr", "<Cmd>lua require'dap'.repl.open()<CR>", options)
vim.keymap.set("n", "<Leader>dl", "<Cmd>lua require'dap'.run_last()<CR>", options)

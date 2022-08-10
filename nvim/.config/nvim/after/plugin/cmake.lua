local Path = require('plenary.path')

require('cmake').setup({
    parameters_file = 'build/nvim_cmake_configuration.json',
    default_projects_path = tostring(Path:new(vim.loop.os_homedir(), 'repos/projects')),
    build_dir = tostring(Path:new('{cwd}', 'build', '{os}-{build_type}')),
    configure_args = { '-D', 'CMAKE_EXPORT_COMPILE_COMMANDS=1' },
    copy_compile_commands = true,
    build_args = {},
    quickfix = {
        pos = 'botright',
        height = 10,
        only_on_error = false,
    },
    dap_configuration = {
        type = 'lldb',
        request = 'launch',
        stopOnEntry = false,
        runInTerminal = false,
    },
    dap_open_command = require('dap').repl.open,
})

local options = { noremap = true, silent = true }
vim.keymap.set("n", "<leader>ccp", ":CMake create_project<CR>", options)
vim.keymap.set("n", "<leader>cst", ":CMake select_target<CR>", options)
vim.keymap.set("n", "<leader>csb", ":CMake select_build_type<CR>", options)
vim.keymap.set("n", "<leader>ccb", ":CMake configure<CR>", options)
vim.keymap.set("n", "<leader>cb", ":CMake build<CR>", options)
vim.keymap.set("n", "<leader>cr", ":CMake run<CR>", options)
vim.keymap.set("n", "<leader>ccl", ":CMake clean<CR>", options)
vim.keymap.set("n", "<leader>cdbg", ":CMake debug<CR>", options)

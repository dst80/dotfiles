local keymap = require("tools.keymap")
local Path = require ('plenary.path')
require('cmake').setup({
  parameters_file = 'build/nvim_cmake_configuration.json',
  build_dir = tostring(Path:new('{cwd}', 'build', '{os}-{build_type}')),
  default_projects_path = tostring(Path:new(vim.loop.os_homedir(), 'repos/projects')),
  configure_args = { '-D', 'CMAKE_EXPORT_COMPILE_COMMANDS=1' },
  build_args = {},
  quickfix_height = 10,
  dap_configuration = { type = 'lldb', request = 'launch' },
  dap_open_command = require('dap').repl.open,
})

local options = {noremap = true, silent = true}
vim.keymap.set("n", "<leader>ccp", ":CMake create_project<CR>", options)
vim.keymap.set("n", "<leader>cst", ":CMake select_target<CR>", options)
vim.keymap.set("n", "<leader>csb", ":CMake select_build_type<CR>", options)
vim.keymap.set("n", "<leader>ccb", ":CMake configure<CR>", options)
vim.keymap.set("n", "<leader>cb", ":CMake build<CR>", options)
vim.keymap.set("n", "<leader>cr", ":CMake run<CR>", options)
vim.keymap.set("n", "<leader>ccl", ":CMake clean<CR>", options)
vim.keymap.set("n", "<leader>cdbg", ":CMake clean<CR>", options)

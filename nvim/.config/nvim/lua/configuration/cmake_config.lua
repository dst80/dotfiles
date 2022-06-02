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

keymap.bind("<leader>ccp"):in_mode('n'):to_command(":CMake create_project<CR>")
keymap.bind("<leader>cst"):in_mode('n'):to_command(":CMake select_target<CR>")
keymap.bind("<leader>csb"):in_mode('n'):to_command(":CMake select_build_type<CR>")
keymap.bind("<leader>ccb"):in_mode('n'):to_command(":CMake configure<CR>")
keymap.bind("<leader>cb"):in_mode('n'):to_command(":CMake build<CR>")
keymap.bind("<leader>cr"):in_mode('n'):to_command(":CMake run<CR>")
keymap.bind("<leader>ccl"):in_mode('n'):to_command(":CMake clean<CR>")
keymap.bind("<leader>cdbg"):in_mode('n'):to_command(":CMake clean<CR>")

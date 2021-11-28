local keymap = require("tools.keymap")

require('cmake').setup({
  parameters_file = 'neovim.json',
  build_dir = tostring(Path:new('{cwd}', 'build', '{os}-{build_type}')),
  configure_args = { '-D', 'CMAKE_EXPORT_COMPILE_COMMANDS=1' },
  build_args = {},
  quickfix_height = 10,
  dap_configuration = { type = 'cpp', request = 'launch' },
  dap_open_command = require('dap').repl.open,
})

keymap.bind("<leader>ccp"):to_command(":Telescope cmake create_project")
keymap.bind("<leader>cst"):to_command(":Telescope cmake select_target")
keymap.bind("<leader>csb"):to_command(":Telescope cmake select_build_type")
keymap.bind("<leader>cc"):to_command(":CMake configure")
keymap.bind("<leader>cb"):to_command(":CMake build")
keymap.bind("<leader>cr"):to_command(":CMake run")
keymap.bind("<leader>ccl"):to_command(":CMake clean")

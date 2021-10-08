local keymap = require("tools.keymap")

keymap.bind("<leader>ccp"):to_command(":Telescope cmake create_project")
keymap.bind("<leader>cst"):to_command(":Telescope cmake select_target")
keymap.bind("<leader>csb"):to_command(":Telescope cmake select_build_type")
keymap.bind("<leader>cc"):to_command(":CMake configure")
keymap.bind("<leader>cb"):to_command(":CMake build")
keymap.bind("<leader>cr"):to_command(":CMake run")
keymap.bind("<leader>ccl"):to_command(":CMake clean")

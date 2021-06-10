local keymap = require('tools.keymap')

keymap.bind('<leader>gs'):to_command(':Git<CR>')
keymap.bind('<leader>gc'):to_command(':G commit<CR>')
keymap.bind('<leader>gd'):to_command(':G diff<CR>')

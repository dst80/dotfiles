local fs = require ('tools.filesystem')
local global = require('global')
vim.g.vsnip_snippet_dir = fs:join_path (global.vim_path, 'snippets')

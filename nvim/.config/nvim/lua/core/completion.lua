if not pcall(require, 'completion') then
  return
end

vim.cmd("imap <tab> <Plug>(completion_smart_tab)")
vim.cmd("imap <S-tab> <Plug>(completion_smart_s_tab)")

local options = require('core.tools.options')

options:set_global_option('completeopt', {'menuone','noinsert','noselect'})
options:add_to_global_option('shortmess', 'c')

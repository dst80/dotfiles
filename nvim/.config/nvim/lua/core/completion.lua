if not pcall(require, 'completion') then
  return
end

vim.cmd("imap <tab> <Plug>(completion_smart_tab)")
vim.cmd("imap <S-tab> <Plug>(completion_smart_s_tab)")

vim.opt.completeopt = {'menuone','noinsert','noselect'}
vim.opt.shortmess:append('c')


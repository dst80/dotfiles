local autocommands = require('core.tools.autocommand')

autocommands.nvim_create_augroups({
  vim_window_command_group = {
    -- Highlight current line only on focused window
    {"WinEnter,BufEnter,InsertLeave", "*", "lua vim.opt.cursorline = true"},
    {"WinLeave,BufLeave,InsertEnter", "*", "lua vim.opt.cursorline = false"},
    -- Equalize window dimensions when resizing vim window
    {"VimResized", "*", "tabdo wincmd ="},
    -- Check if file changed when its window is focus, more eager than 'autoread'
    {"FocusGained", "* checktime"},
  }
})

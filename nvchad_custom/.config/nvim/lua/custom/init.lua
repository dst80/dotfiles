-- vscode format i.e json files
--vim.g.vscode_snippets_path = "your snippets path"

-- snipmate format
--vim.g.snipmate_snippets_path = "your snippets path"

-- lua format
---vim.g.lua_snippets_path = vim.fn.stdpath "config" .. "/lua/custom/lua_snippets"

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes:2"

-- undo different
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.history = 2000
vim.opt.undofile = true

-- time out and drawing
vim.opt.timeout = true
vim.opt.ttimeout = true
vim.opt.timeoutlen = 500
vim.opt.ttimeoutlen = 50
vim.opt.updatetime = 100
vim.opt.redrawtime = 500

if vim.loop.os_uname().sysname == "Windows_NT" then
  vim.opt.undodir = os.getenv("USERPROFILE") .. "/.cache/nvim/undodir"
else
  vim.opt.undodir = os.getenv("HOME") .. "/.cache/nvim/undodir"
end

vim.opt.shada = "!,'300,<50,@100,s10,h"
vim.opt.backupskip = "/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*,/private/var/*,.vault.vim"

-- error bell
vim.opt.errorbells = false
vim.opt.visualbell = true

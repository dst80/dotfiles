local M = {}

function M.setup()
    vim.opt.magic = true
    vim.opt.viewoptions = "folds,cursor,curdir,slash,unix"
    vim.opt.sessionoptions = "curdir,help,tabpages,winsize"
    vim.opt.clipboard = "unnamedplus"
    vim.opt.fileformats = "unix,mac,dos"
    vim.opt.encoding = "utf-8"

    -- allow hidden buffers
    vim.opt.hidden = true

    -- time out and drawing
    vim.opt.timeout = true
    vim.opt.ttimeout = true
    vim.opt.timeoutlen = 500
    vim.opt.ttimeoutlen = 50
    vim.opt.updatetime = 100
    vim.opt.redrawtime = 500

    -- cursor control
    vim.opt.backspace = "indent,eol,start"
    vim.opt.mouse = "nv"

    -- formatting stuff
    vim.opt.tabstop = 4
    vim.opt.shiftwidth = 4
    vim.opt.softtabstop = 4
    vim.opt.scrolloff = 8
    vim.opt.autoindent = true
    vim.opt.wrap = false

    vim.opt.number = true
    vim.opt.relativenumber = true
    vim.opt.signcolumn = "yes"

    -- list chars
    vim.opt.list = true
    vim.opt.showbreak = "↳  "
    vim.opt.listchars = "tab:>->,nbsp:+,space:·,trail:█,extends:→,precedes:←,eol:¬"

    -- settings for :grep
    vim.opt.grepformat = "%f:%l:%c:%m"
    vim.opt.grepprg = 'rg --hidden --vimgrep --smart-case --'

    -- searching
    vim.opt.hlsearch = false
    vim.opt.incsearch = true
    vim.opt.smartcase = true
    vim.opt.inccommand = "nosplit"
    vim.opt.wildignorecase = true
    vim.opt.wildignore =
    ".git,.hg,.svn,*.pyc,*.o,*.out,*.jpg,*.jpeg,*.png,*.gif,*.zip,**/tmp/**,*.DS_Store,**/node_modules/**,**/bower_modules/**"

    -- undo different
    vim.opt.backup = false
    vim.opt.writebackup = false
    vim.opt.swapfile = false
    vim.opt.history = 2000
    vim.opt.undofile = true

    if (vim.loop.os_uname().sysname == "Windows_NT") then
        vim.opt.undodir = os.getenv("USERPROFILE") .. "/.cache/nvim/undodir"
    else
        vim.opt.undodir = os.getenv("HOME") .. "/.cache/nvim/undodir"
    end

    vim.opt.shada = "!,'300,<50,@100,s10,h"
    vim.opt.backupskip = "/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*,/private/var/*,.vault.vim"

    -- error bell
    vim.opt.errorbells = false
    vim.opt.visualbell = true
    vim.o.termguicolors = true

    vim.filetype.add({ extension = { wgsl = "wgsl" } })
end

return M

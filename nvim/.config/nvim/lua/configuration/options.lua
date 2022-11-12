local options = require('tools.options')

options:set_options({
    magic = true,
    viewoptions = "folds,cursor,curdir,slash,unix",
    sessionoptions = "curdir,help,tabpages,winsize",
    clipboard = "unnamedplus",
    fileformats = "unix,mac,dos",
    encoding = "utf-8",

    -- allow hidden buffers
    hidden = true,

    -- time out and drawing
    timeout = true,
    ttimeout = true,
    timeoutlen = 500,
    ttimeoutlen = 50,
    updatetime = 300,
    redrawtime = 1500,
    wrapscan = true,

    -- cursor control
    breakat = [[\ \t,:,!?]],
    startofline = false,
    backspace = "indent,eol,start",
    mouse = "nv",
    whichwrap = "h,l,<,>,[,],~",
    virtualedit = "block",
    scrolloff = 35,
    sidescrolloff = 5,

    -- formatting stuff
    smarttab = true,
    shiftround = true,
    tabstop = 4,
    shiftwidth = 4,
    softtabstop = -1,
    expandtab = true,
    autoindent = true,
    colorcolumn = { 80, 120, 140 },
    breakindentopt = "shift:2,min:20",
    wrap = false,
    linebreak = true,

    -- nvim visual settings
    termguicolors = true,
    winwidth = 30,
    winminwidth = 10,
    pumheight = 15,
    helpheight = 12,
    previewheight = 12,
    cmdheight = 2,
    cmdwinheight = 5,
    equalalways = false,
    pumblend = 10,
    winblend = 10,
    laststatus = 2,
    signcolumn = 'yes',

    -- tab settings
    splitbelow = true,
    splitright = true,
    switchbuf = "useopen",
    diffopt = "filler,iwhite,internal,algorithm:patience",
    jumpoptions = "stack",
    ruler = false,
    showtabline = 2,
    number = true,
    relativenumber = true,

    -- list chars
    list = true,
    showbreak = "↳  ",
    listchars = "tab:>->,nbsp:+,space:·,trail:█,extends:→,precedes:←,eol:¬",

    -- last line
    showmode = true,
    showcmd = true,
    display = "lastline",

    -- settings for :grep
    grepformat = "%f:%l:%c:%m",
    grepprg = 'rg --hidden --vimgrep --smart-case --',

    -- searching
    hlsearch = true,
    incsearch = true,
    smartcase = true,
    showmatch = true,
    infercase = true,
    inccommand = "nosplit",
    wildignorecase = true,
    wildignore = ".git,.hg,.svn,*.pyc,*.o,*.out,*.jpg,*.jpeg,*.png,*.gif,*.zip,**/tmp/**,*.DS_Store,**/node_modules/**,**/bower_modules/**",

    -- undo different
    backup = false,
    writebackup = false,
    swapfile = false,
    history = 2000,
    undofile = true,
    shada = "!,'300,<50,@100,s10,h",
    backupskip = "/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*,/private/var/*,.vault.vim",

    -- error bell
    errorbells = false,
    visualbell = true
})

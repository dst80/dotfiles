
call plug#begin('~/.vim/plugged')

Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'simrat39/symbols-outline.nvim'


Plug 'arcticicestudio/nord-vim'

call plug#end()

colorscheme nord

lua require("core")

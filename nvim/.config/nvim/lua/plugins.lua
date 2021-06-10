if not pcall(require, 'packer') then
    vim.cmd(
        "!git clone https://github.com/wbthomason/packer.nvim " ..
            "~/.local/share/nvim/site/pack/packer/start/packer.nvim"
    )
end
return require("packer").startup(
           function(use)
        use 'wbthomason/packer.nvim'
        use {'neovim/nvim-lspconfig', config = require('configuration.lsp')}
        use {'hrsh7th/nvim-compe', config = require('configuration.completion')}
        use {
            'nvim-lua/lsp_extensions.nvim',
            config = require('configuration.lsp_extension')
        }

        -- tpope best's
        use 'tpope/vim-surround'
        use {'tpope/vim-fugitive', config = require('configuration.fugitive')}
        use 'tpope/vim-commentary'

        -- nvim tree sitter
        use {
            'nvim-treesitter/nvim-treesitter',
            run = ':TSUpdate',
            requires = {{'nvim-treesitter/playground'}},
            config = require('configuration.treesitter')
        }
        use {'kyazdani42/nvim-web-devicons', config = require('configuration.icons')}

        -- telescope requirements
        use {
            'nvim-telescope/telescope.nvim',
            requires = {
                {'nvim-lua/popup.nvim'},
                {'nvim-lua/plenary.nvim'},
                {'nvim-telescope/telescope-fzy-native.nvim'},
                {'kyazdani42/nvim-web-devicons'}
            },
            config = require('configuration.telescope')

        }
        use {
            'sudormrfbin/cheatsheet.nvim',
            requires = {
                {'nvim-telescope/telescope.nvim'},
                {'nvim-lua/popup.nvim'},
                {'nvim-lua/plenary.nvim'}
            }
        }

        -- format
        use {'lukas-reineke/format.nvim', config = require('configuration.format')}
        -- snipping
        use {
            'hrsh7th/vim-vsnip-integ',
            requires = {{'hrsh7th/vim-vsnip'}},
            config = require('configuration.snippets')
        }

        -- python stuff
        -- use 'ambv/black'

        -- other languages
        use {'fatih/vim-go'}
        use {'rust-lang/rust.vim'}

        -- status line
        use {
            'hoob3rt/lualine.nvim',
            requires = {'kyazdani42/nvim-web-devicons', opt = true},
            config = require('configuration.lualine')
        }

        -- color settings
        use {
            'tjdevries/colorbuddy.nvim',
            requires = {
                {'hoob3rt/lualine.nvim'},
                {'nvim-telescope/telescope.nvim'},
                {'neovim/nvim-lspconfig'}
            },
            config = require('configuration.colors')
        }
    end
       )


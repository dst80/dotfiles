local globals = require('global')
local sumneko = require('configuration.sumneko')

if not pcall(require, 'packer') then
    if globals.is_windows then
        vim.cmd ("git clone https://github.com/wbthomason/packer.nvim" ..
            globals.home ..
            "AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\packer.nvim")
    elseif globals.is_linux then
    vim.cmd(
        "!git clone https://github.com/wbthomason/packer.nvim " ..
            "~/.local/share/nvim/site/pack/packer/start/packer.nvim"
    )
        end
end
return require("packer").startup(
           function(use)
        use 'wbthomason/packer.nvim'
        use {
            'neovim/nvim-lspconfig',
            run = function()
                sumneko:install()
            end,
            config = function()
                require('configuration.lsp')
            end
        }
        use {
            'hrsh7th/nvim-compe',
            config = function()
                require('configuration.completion')
            end
        }
        use {
            'nvim-lua/lsp_extensions.nvim',
            config = function()
                require('configuration.lsp_extension')
            end
        }

        -- tpope best's
        use 'tpope/vim-surround'
        use {
            'tpope/vim-fugitive',
            config = function()
                require('configuration.fugitive')
            end
        }
        use 'tpope/vim-commentary'

        -- nvim tree sitter
        use {
            'nvim-treesitter/nvim-treesitter',
            run = ':TSUpdate',
            requires = {{'nvim-treesitter/playground'}},
            config = function()
                require('configuration.treesitter')
            end
        }
        use {
            'kyazdani42/nvim-web-devicons',
            config = function()
                require('configuration.icons')
            end
        }

        -- telescope requirements
        use {
            'nvim-telescope/telescope.nvim',
            requires = {
                {'nvim-lua/popup.nvim'},
                {'nvim-lua/plenary.nvim'},
                {'nvim-telescope/telescope-fzy-native.nvim'},
                {'kyazdani42/nvim-web-devicons'}
            },
            config = function()
                require('configuration.telescope')
            end

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
        use {
            'lukas-reineke/format.nvim',
            config = function()
                require('configuration.format')
            end
        }
        -- snipping
        use {
            'hrsh7th/vim-vsnip-integ',
            requires = {{'hrsh7th/vim-vsnip'}},
            config = function()
                require('configuration.snippets')
            end
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
            config = function()
                require('configuration.lualine')
            end
        }

        -- color settings
        use {
            'tjdevries/colorbuddy.nvim',
            requires = {
                {'hoob3rt/lualine.nvim'},
                {'nvim-telescope/telescope.nvim'},
                {'neovim/nvim-lspconfig'}
            },
            config = function()
                require('configuration.colors')
            end
        }
    end
       )


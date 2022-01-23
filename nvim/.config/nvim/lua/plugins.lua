local globals = require('global')
local sumneko = require('configuration.sumneko')

if not pcall(require, 'packer') then
    vim.cmd(
        "!git clone https://github.com/wbthomason/packer.nvim " ..
            globals.site_dir .. "pack/packer/start/packer.nvim"
    )
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
            'hrsh7th/nvim-cmp',
            requires = {'hrsh7th/cmp-nvim-lsp'},
            config = function()
                require('configuration.completion')
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
        --TODO: look for an alternative Cmake plugin, which is not so inversive
        use {
            'Shatur/neovim-cmake',
            requires = {
                    {'nvim-telescope/telescope.nvim'},
                    {'mfussenegger/nvim-dap'}
                },
            config = function()
                require('configuration.cmake_config')
            end
        }
        -- snipping
        use {
            'dcampos/nvim-snippy',
            requires = {
                'dcampos/cmp-snippy'
            },
            config = function()
                require('configuration.snippets')
            end
        }
        use {
            'windwp/nvim-autopairs',
            config = function ()
                require('configuration.autopairs')
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

        -- dashboard
        use {
            'goolord/alpha-nvim',
            config = function ()
                require ('configuration.alpha')
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


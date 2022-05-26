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
            end,
            requires = {
                'lukas-reineke/lsp-format.nvim',
            }
        }

        use {
            'williamboman/nvim-lsp-installer',
        }

        use {
            'hrsh7th/nvim-cmp',
            requires = {
                'hrsh7th/cmp-nvim-lsp',
                'hrsh7th/cmp-path',
                'hrsh7th/cmp-buffer'
                },
            config = function()
                require('configuration.completion')
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

        -- tpope best's
        use 'tpope/vim-surround'

        use {
            'tpope/vim-fugitive',
            config = function()
                require('configuration.fugitive')
            end
        }

        use {
            'numToStr/Comment.nvim'
        }

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

        use {
            'nvim-telescope/telescope.nvim',
            requires = {
                'nvim-lua/popup.nvim',
                'nvim-lua/plenary.nvim',
                'nvim-telescope/telescope-file-browser.nvim',
                {'nvim-telescope/telescope-fzf-native.nvim', run='make'},
                'nvim-telescope/telescope-ui-select.nvim',
                'kyazdani42/nvim-web-devicons'
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

        use {
            'p00f/clangd_extensions.nvim',
            config = function ()
                require('configuration.clangd_extension')
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

        use {
            'windwp/nvim-autopairs',
            config = function ()
                require('configuration.autopairs')
            end
        }

        use {
            'mfussenegger/nvim-dap',
            config = function()
                require('configuration.debug_adapter_protocol')
            end
        }

        use {
            "rcarriga/nvim-dap-ui",
            requires = {
                'mfussenegger/nvim-dap'
            },
            config = function ()
                require('configuration.debug_adapter_protocol_ui')
            end
        }

        use {'fatih/vim-go'}

        use {'simrat39/rust-tools.nvim'}

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
            'andersevenrud/nordic.nvim',
            config = function()
                require('configuration.colors')
            end
        }
    end
)


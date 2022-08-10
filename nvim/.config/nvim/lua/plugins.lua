local globals = require('global')

if not pcall(require, 'packer') then
    vim.cmd(
        '!git clone https://github.com/wbthomason/packer.nvim ' ..
        globals.site_dir .. 'pack/packer/start/packer.nvim'
    )
end

return require('packer').startup(

    function(use)
        use 'wbthomason/packer.nvim'
        use {
            'neovim/nvim-lspconfig',
            config = function()
                require('configuration.lsp')
            end,
            requires = {
                'lukas-reineke/lsp-format.nvim',
                'williamboman/nvim-lsp-installer'
            }
        }

        use { 'williamboman/nvim-lsp-installer' }


        use { 'saadparwaiz1/cmp_luasnip' }
        use {
            'L3MON4D3/LuaSnip',
            requires = {
                'saadparwaiz1/cmp_luasnip',
            },
            config = function()
                require('configuration.luasnip')
            end
        }

        use {
            'hrsh7th/nvim-cmp',
            requires = {
                'saadparwaiz1/cmp_luasnip',
                'hrsh7th/cmp-nvim-lsp',
                'hrsh7th/cmp-nvim-lua',
                'hrsh7th/cmp-path',
                'hrsh7th/cmp-buffer',
            },
            config = function()
                require('configuration.completion')
            end
        }

        -- tpope best's
        use {
            'tpope/vim-fugitive',
            config = function()
                require('configuration.fugitive')
            end
        }

        use { 'kylechui/nvim-surround' }

        use { 'numToStr/Comment.nvim' }

        -- nvim tree sitter
        use {
            'nvim-treesitter/nvim-treesitter',
            run = ':TSUpdate',
            requires = { { 'nvim-treesitter/playground' } },
            config = function()
                require('configuration.treesitter')
            end
        }

        use { 'ThePrimeagen/refactoring.nvim' }

        use {
            'nvim-telescope/telescope-fzf-native.nvim',
            run = 'cmake -S . -B build -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
        }

        use { 'nvim-lua/popup.nvim' }
        use { 'nvim-lua/plenary.nvim' }
        use { 'nvim-telescope/telescope.nvim' }
        use { 'nvim-telescope/telescope-file-browser.nvim'}
        use { 'nvim-telescope/telescope-ui-select.nvim'}
        use { 'kyazdani42/nvim-web-devicons'}
        use { 'sudormrfbin/cheatsheet.nvim' }

        use {
            'akinsho/toggleterm.nvim',
            config = function()
                require('configuration.terminal')
            end
        }

        use {
            'p00f/clangd_extensions.nvim',
            config = function()
                require('configuration.clangd_extension')
            end
        }

        --TODO: look for an alternative Cmake plugin, which is not so inversive
        use {
            'Shatur/neovim-cmake',
            requires = {
                { 'nvim-telescope/telescope.nvim' },
                { 'mfussenegger/nvim-dap' }
            },
            config = function()
                require('configuration.cmake_config')
            end
        }

        use { 'windwp/nvim-autopairs' }

        use { 'mfussenegger/nvim-dap' }
        use { 'rcarriga/nvim-dap-ui' }
        use { 'theHamsta/nvim-dap-virtual-text'}
        use { 'nvim-telescope/telescope-dap.nvim'}

        use { 'fatih/vim-go' }

        use { 'simrat39/rust-tools.nvim' }

        -- status line
        use { 'hoob3rt/lualine.nvim' }

        -- dashboard
        use { 'goolord/alpha-nvim' }

        -- color settings
        use { 'andersevenrud/nordic.nvim' }

        use {
            'iamcco/markdown-preview.nvim',
            run = function()
                vim.fn["mkdp#util#install"]()
            end,
        }
    end
)

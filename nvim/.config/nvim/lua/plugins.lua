local globals = require('global')

if not pcall(require, 'packer') then
    vim.cmd(
        '!git clone https://github.com/wbthomason/packer.nvim ' ..
        globals.site_dir .. 'pack/packer/start/packer.nvim'
    )
end


return require('packer').startup(

    function(use)
        use {'wbthomason/packer.nvim'}

        use { 'neovim/nvim-lspconfig' }
        use { 'lukas-reineke/lsp-format.nvim' }
        use { 'onsails/lspkind.nvim' }

        use { 'williamboman/mason.nvim' }
        use { 'williamboman/mason-lsp-config.nvim'}

        use { 'hrsh7th/nvim-cmp' }
        use { 'hrsh7th/cmp-nvim-lsp' }
        use { 'hrsh7th/cmp-nvim-lua' }
        use { 'hrsh7th/cmp-path' }
        use { 'hrsh7th/cmp-buffer' }
        use { 'L3MON4D3/LuaSnip' }
        use { 'saadparwaiz1/cmp_luasnip' }
        if (vim.loop.os_uname().sysname == 'Windows_NT') then
            use { 'tzachar/cmp-tabnine', after='nvim-cmp', run='powershell ./install.ps1'}
        else
            use { 'tzachar/cmp-tabnine', run='./install.sh'}
        end

        -- tpope best's
        use { 'tpope/vim-fugitive' }

        use { 'kylechui/nvim-surround' }

        use { 'numToStr/Comment.nvim' }

        -- nvim tree sitter
        use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
        use { 'nvim-treesitter/playground' }
        use { 'romgrk/nvim-treesitter-context' }

        use { 'ThePrimeagen/refactoring.nvim' }

        use {
            'nvim-telescope/telescope-fzf-native.nvim',
            run = 'cmake -S . -B build -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
        }

        use { 'nvim-lua/popup.nvim' }
        use { 'nvim-lua/plenary.nvim' }
        use { 'nvim-telescope/telescope.nvim' }
        use { 'nvim-telescope/telescope-file-browser.nvim' }
        use { 'nvim-telescope/telescope-ui-select.nvim' }
        use { 'kyazdani42/nvim-web-devicons' }
        use { 'sudormrfbin/cheatsheet.nvim' }

        use { 'akinsho/toggleterm.nvim' }

        use {
            'p00f/clangd_extensions.nvim',
            config = function()
                require('configuration.clangd_extension')
            end
        }

        --TODO: look for an alternative Cmake plugin. which is not so inversive
        use { 'Shatur/neovim-cmake' }

        use { 'windwp/nvim-autopairs' }

        use { 'mfussenegger/nvim-dap' }
        use { 'rcarriga/nvim-dap-ui' }
        use { 'theHamsta/nvim-dap-virtual-text' }
        use { 'nvim-telescope/telescope-dap.nvim' }

        use { 'fatih/vim-go' }

        use { 'simrat39/rust-tools.nvim' }

        -- status line
        use { 'hoob3rt/lualine.nvim' }
        use { 'lukas-reineke/indent-blankline.nvim' }
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

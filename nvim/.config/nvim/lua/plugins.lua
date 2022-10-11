local globals = require('global')

if not pcall(require, 'packer') then
    vim.cmd(
        '!git clone https://github.com/wbthomason/packer.nvim ' ..
        globals.site_dir .. 'pack/packer/start/packer.nvim'
    )
end


return require('packer').startup(
    function(use)
        use { 'wbthomason/packer.nvim' }

        -- lsp basics
        use { 'neovim/nvim-lspconfig' }
        use { 'lukas-reineke/lsp-format.nvim' }
        use { 'onsails/lspkind.nv' }
        use { 'p00f/clangd_extensions.nvim' }

        -- lsp config helper
        use { 'williamboman/mason.nvim' }
        use { 'williamboman/mason-lspconfig.nvim' }

        -- completion
        use { 'hrsh7th/nvim-cmp' }
        use { 'hrsh7th/cmp-nvim-lsp' }
        use { 'hrsh7th/cmp-nvim-lua' }
        use { 'hrsh7th/cmp-path' }
        use { 'hrsh7th/cmp-buffer' }
        use { 'L3MON4D3/LuaSnip' }
        use { 'saadparwaiz1/cmp_luasnip' }
        if (vim.loop.os_uname().sysname == 'Windows_NT') then
            use { 'tzachar/cmp-tabnine', after = 'nvim-cmp', run = 'powershell ./install.ps1' }
        else
            use { 'tzachar/cmp-tabnine', run = './install.sh' }
        end

        -- nvim tree sitter
        use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
        use { 'nvim-treesitter/playground' }
        use { 'romgrk/nvim-treesitter-context' }

        -- telescope, what else
        use { 'nvim-lua/popup.nvim' }
        use { 'nvim-lua/plenary.nvim' }
        use { 'nvim-telescope/telescope.nvim' }
        use { 'nvim-telescope/telescope-file-browser.nvim' }
        use { 'nvim-telescope/telescope-ui-select.nvim' }
        use { 'kyazdani42/nvim-web-devicons' }
        use {
            'nvim-telescope/telescope-fzf-native.nvim',
            run = 'cmake -S . -B build -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
        }

        -- debugging
        use { 'mfussenegger/nvim-dap' }
        use { 'rcarriga/nvim-dap-ui' }
        use { 'theHamsta/nvim-dap-virtual-text' }
        use { 'nvim-telescope/telescope-dap.nvim' }

        -- editing
        use { 'kylechui/nvim-surround' }
        use { 'numToStr/Comment.nvim' }
        use { 'windwp/nvim-autopairs' }

        -- terminal support
        use { 'akinsho/toggleterm.nvim' }

        -- cool refactoring plugin
        use { 'ThePrimeagen/refactoring.nvim' }

        -- some language plugins
        use { 'Shatur/neovim-cmake' }
        use { 'fatih/vim-go' }
        use { 'simrat39/rust-tools.nvim' }
        use {'iamcco/markdown-preview.nvim',
            run = function()
                vim.fn["mkdp#util#install"]()
            end,
        }

        -- optical sugar
        use { 'hoob3rt/lualine.nvim' }
        use { 'lukas-reineke/indent-blankline.nvim' }
        use { 'goolord/alpha-nvim' }
        use { 'sudormrfbin/cheatsheet.nvim' }
        use { 'andersevenrud/nordic.nvim' }

    end
)

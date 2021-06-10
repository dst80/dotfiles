if not pcall(require, 'packer') then
    vim.cmd("!git clone https://github.com/wbthomason/packer.nvim " ..
                "~/.local/share/nvim/site/pack/packer/start/packer.nvim")
end
return require("packer").startup(function(use)
    use 'wbthomason/packer.nvim'
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/nvim-compe'
    use 'nvim-lua/lsp_extensions.nvim'

    -- tpope best's
    use 'tpope/vim-surround'
    use 'tpope/vim-fugitive'
    use 'tpope/vim-commentary'

    -- nvim tree sitter
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        requires = {{'nvim-treesitter/playground'}}
    }

    -- telescope requirements
    use {
        'nvim-telescope/telescope.nvim',
        requires = {
            {'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'},
            {'nvim-telescope/telescope-fzy-native.nvim'},
            {'kyazdani42/nvim-web-devicons'}
        }
    }
    use {
        'sudormrfbin/cheatsheet.nvim',

        requires = {
            {'nvim-telescope/telescope.nvim'}, {'nvim-lua/popup.nvim'},
            {'nvim-lua/plenary.nvim'}
        }
    }

    -- format
    use {'lukas-reineke/format.nvim'}
    -- snipping
    use {'hrsh7th/vim-vsnip-integ', requires = {{'hrsh7th/vim-vsnip'}}}

    -- python stuff
    -- use 'ambv/black'

    -- other languages
    use {'fatih/vim-go'}
    use {'rust-lang/rust.vim'}

    -- color settings
    use 'tjdevries/colorbuddy.nvim'
end)

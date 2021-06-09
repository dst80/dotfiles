if not pcall(require,'packer') then
  vim.cmd("!git clone https://github.com/wbthomason/packer.nvim " .. "~/.local/share/nvim/site/pack/packer/start/packer.nvim")
end

return require("packer").startup (
  function(use)
    use 'wbthomason/packer.nvim'
    use 'neovim/nvim-lspconfig'
    use 'nvim-lua/completion-nvim'
    use 'simrat39/symbols-outline.nvim'
    use 'tpope/vim-surround'
    use 'tpope/vim-fugitive'
    use 'tpope/vim-commentary'
    use 'nvim-lua/lsp_extensions.nvim'

    -- nvim tree sitter
    use {
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate',
      requires = {
        {'nvim-treesitter/playground'}
      }
    }

    -- telescope requirements
    use {
      'nvim-telescope/telescope.nvim',
      requires = {
        {'nvim-lua/popup.nvim'},
        {'nvim-lua/plenary.nvim'},
        {'nvim-telescope/telescope-fzy-native.nvim'},
        {'kyazdani42/nvim-web-devicons'}
      }
    }
    use {
      'sudormrfbin/cheatsheet.nvim',

       requires = {
         {'nvim-telescope/telescope.nvim'},
         {'nvim-lua/popup.nvim'},
         {'nvim-lua/plenary.nvim'},
      }
    }
    -- color settings
    use 'tjdevries/colorbuddy.nvim'
  end
)

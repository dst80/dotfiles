if not pcall(require,'packer') then
  vim.cmd("!git clone https://github.com/wbthomason/packer.nvim " .. "~/.local/share/nvim/site/pack/packer/start/packer.nvim")
end

return require("packer").startup (
  function(use)
    use {"wbthomason/packer.nvim"}
    use 'neovim/nvim-lspconfig'
    use 'nvim-lua/completion-nvim'
    use 'simrat39/symbols-outline.nvim'

    use 'nvim-lua/lsp_extensions.nvim'

    use 'arcticicestudio/nord-vim'

    -- Neovim Tree shitteri
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use 'nvim-treesitter/playground'

    -- telescope requirements...
    use 'nvim-lua/popup.nvim'
    use 'nvim-lua/plenary.nvim'
    use 'nvim-telescope/telescope.nvim'
    use 'nvim-telescope/telescope-fzy-native.nvim'
  end
)

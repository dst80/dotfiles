local plugins = {
  {
    "williamboman/mason.nvim",
    opts = require("custom.config.lsp").mason_opts,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = require("custom.config.treesitter").opts,
  },
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = require("custom.config.telescope").dependencies,
    config = require("custom.config.telescope").config,
  },
  {
    "neovim/nvim-lspconfig",
    config = require("custom.config.lsp").config,
    dependencies = require("custom.config.lsp").dependencies,
  },
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = require("custom.config.cmp").dependencies,
    opts = require("custom.config.cmp").opts,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    ft = require("custom.config.null-ls").filetype,
    config = require("custom.config.null-ls").config,
    dependencies = require("custom.config.null-ls").dependencies,
  },
  {
    "mfussenegger/nvim-dap",
    ft = require("custom.config.dap").filetype,
    config = require("custom.config.dap").config,
    dependencies = require("custom.config.dap").dependencies,
  },
  {
    "p00f/clangd_extensions.nvim",
    ft = require("custom.config.clangd-extensions").filetype,
    config = require("custom.config.clangd-extensions").config,
    dependencies = require("custom.config.clangd-extensions").dependencies,
  },
  {
    "simrat39/rust-tools.nvim",
    ft = require("custom.config.rust-tools").filetype,
    config = require("custom.config.rust-tools").config,
    dependencies = require("custom.config.rust-tools").dependencies,
  },
  {
    "ThePrimeagen/refactoring.nvim",
    ft = require("custom.config.refactoring").filetype,
    config = require("custom.config.refactoring").config,
  },
  {
    "Civitasv/cmake-tools.nvim",
    ft = require("custom.config.cmake").filetype,
    config = require("custom.config.cmake").config,
    dependencies = require("custom.config.cmake").dependencies,
  },
  {
    "zbirenbaum/copilot.lua",
    config = require("custom.config.copilot").config,
    dependencies = require("custom.config.copilot").dependencies,
  },
  {
    "nvim-neotest/neotest",
    ft = require("custom.config.neotest").filetype,
    config = require("custom.config.neotest").config,
    dependencies = require("custom.config.neotest").dependencies,
  },
  {
    "kylechui/nvim-surround",
    lazy = true,
    event = "InsertEnter",
    config = require("custom.config.surround").config,
  },
  {
    "iamcco/markdown-preview.nvim",
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    ft = { "markdown" },
  },
}

return plugins

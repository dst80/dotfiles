if not pcall(require, "packer") then
    vim.cmd(
        "!git clone https://github.com/wbthomason/packer.nvim " ..
        vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
    )
end


return require("packer").startup(
    function(use)
        use { "wbthomason/packer.nvim" }

        -- lsp basics
        use { "neovim/nvim-lspconfig" }
        use { "lukas-reineke/lsp-format.nvim" }
        use { "onsails/lspkind.nvim" }
        use { "p00f/clangd_extensions.nvim" }
        use { "jose-elias-alvarez/null-ls.nvim" }

        -- lsp config helper
        use { "williamboman/mason.nvim" }
        use { "williamboman/mason-lspconfig.nvim" }

        -- completion
        use { "hrsh7th/nvim-cmp" }
        use { "hrsh7th/cmp-nvim-lsp" }
        use { "hrsh7th/cmp-nvim-lua" }
        use { "hrsh7th/cmp-path" }
        use { "hrsh7th/cmp-buffer" }
        use { "L3MON4D3/LuaSnip" }
        use { "saadparwaiz1/cmp_luasnip" }
        if (vim.loop.os_uname().sysname == "Windows_NT") then
            use { "tzachar/cmp-tabnine", run = "powershell ./install.ps1" }
        else
            use { "tzachar/cmp-tabnine", run = "./install.sh" }
        end

        -- nvim tree sitter
        use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }
        use { "nvim-treesitter/nvim-treesitter-textobjects" }
        use { "nvim-treesitter/playground" }

        -- telescope, what else
        use { "nvim-lua/popup.nvim" }
        use { "nvim-lua/plenary.nvim" }
        use { "nvim-telescope/telescope.nvim" }
        use { "nvim-telescope/telescope-file-browser.nvim" }
        use { "nvim-telescope/telescope-ui-select.nvim" }
        use { "kyazdani42/nvim-web-devicons" }
        use {
            "nvim-telescope/telescope-fzf-native.nvim",
            run = "cmake -S . -B build -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
        }

        -- debugging
        use { "mfussenegger/nvim-dap" }
        use { "rcarriga/nvim-dap-ui" }
        use { "theHamsta/nvim-dap-virtual-text" }
        use { "nvim-telescope/telescope-dap.nvim" }

        -- editing
        use { "kylechui/nvim-surround" }
        use { "numToStr/Comment.nvim" }
        use { "windwp/nvim-autopairs" }

        -- terminal support
        use { "akinsho/toggleterm.nvim" }

        -- cool refactoring plugin
        use { "ThePrimeagen/refactoring.nvim" }

        -- some language plugins
        use { "Civitasv/cmake-tools.nvim" }
        use { "simrat39/rust-tools.nvim" }
        use { "fatih/vim-go" }
        use { "iamcco/markdown-preview.nvim",
            run = function()
                vim.fn["mkdp#util#install"]()
            end,
        }

        -- test
        use { "nvim-neotest/neotest" }
        use { "nvim-neotest/neotest-go" }
        use { "nvim-neotest/neotest-python" }
        use { "rouge8/neotest-rust" }
        use { "Issafalcon/neotest-dotnet" }

        -- optical sugar
        use { "hoob3rt/lualine.nvim" }
        use { "akinsho/bufferline.nvim" }
        use { "lukas-reineke/indent-blankline.nvim" }
        use { "andersevenrud/nordic.nvim" }
        use { "lewis6991/gitsigns.nvim" }
        use { "petertriho/nvim-scrollbar" }

    end
)

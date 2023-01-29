local M = {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = function()
        pcall(require('nvim-treesitter.install').update { with_sync = true })
    end,
    dependencies = {
        'nvim-treesitter/nvim-treesitter-textobjects',
        "nvim-treesitter/playground",
    },
    lazy = true,
    event = "BufReadPost",
}


function M.config()
    require("nvim-treesitter.configs").setup {
        ensure_installed = {
            "bash", "c", "cpp", "c_sharp", "css", "scss", "html", "javascript",
            "java", "json", "lua", "rust", "go", "typescript", "markdown", "python",
            "vue", "graphql", "glsl", "make", "toml", "yaml",
        },
        ignore_install = {
            "beancount", "bibtex", "dart", "devicetree", "dot", "elixir", "elm",
            "erlang", "fennel", "fish", "fortran", "Godot", "Glimmer and Ember",
            "Godot Resources", "gomod", "gdscript", "haskell", "hcl",
            "heex", "ledger", "nix", "ocaml", "ocaml_interface", "ocamllex", "php",
            "pioasm", "ql", "r", "rst", "scala", "sparql", "supercollider",
            "surface", "svelte", "teal", "tlaplus", "turtle", "verilog",
            "yang"
        },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "<c-space>",
                node_incremental = "<c-space>",
                scope_incremental = "<c-s>",
                node_decremental = "<c-backspace>"
            }
        },
        indent = { enable = true },
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
            use_languagetree = true,
        },
        textobjects = {
            select = {
                enable = true,
                lookahead = true,
                keymaps = {
                    ['aa'] = '@parameter.outer',
                    ['ia'] = '@parameter.inner',
                    ['af'] = '@function.outer',
                    ['if'] = '@function.inner',
                    ['ac'] = '@class.outer',
                    ['ic'] = '@class.inner',
                },
            },
            move = {
                enable = true,
                set_jumps = true,
                goto_next_start = {
                    [']m'] = '@function.outer',
                    [']]'] = '@class.outer',
                },
                goto_next_end = {
                    [']M'] = '@function.outer',
                    [']['] = '@class.outer',
                },
                goto_previous_start = {
                    ['[m'] = '@function.outer',
                    ['[['] = '@class.outer',
                },
                goto_previous_end = {
                    ['[M'] = '@function.outer',
                    ['[]'] = '@class.outer',
                },
            },
            swap = {
                enable = true,
                swap_next = {
                    ['<leader>a'] = '@parameter.inner',
                },
                swap_previous = {
                    ['<leader>A'] = '@parameter.inner',
                },
            },
        },
    }

    vim.keymap.set(
        "n",
        "<leader>rts",
        ":write | edit | TSBufEnable highlight<CR>",
        { silent = true, noremap = true })
end

return M

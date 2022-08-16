require'nvim-treesitter.install'.compilers = { "clang" }

require'nvim-treesitter.configs'.setup {
    ensure_installed = {
        "c", "cpp", "c_sharp", "css", "scss", "html", "javascript", "java",
        "lua", "rust", "go",
    },
    ignore_install = {
        "beancount", "bibtex", "dart", "devicetree", "dot", "elixir", "elm",
        "erlang", "fennel", "fish", "fortran", "Godot", "Glimmer and Ember",
        "Godot Resources", "gomod", "gdscript", "graphql", "haskell", "hcl",
        "heex", "ledger", "nix", "ocaml", "ocaml_interface", "ocamllex", "php",
        "pioasm", "ql", "r", "rst", "scala", "sparql", "supercollider",
        "surface", "svelte", "teal", "tlaplus", "toml", "turtle", "verilog",
        "vue", "yang", "zig"
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm"
        }
    },
    indent = {enable = true},
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    }
}

vim.keymap.set("n", "<leader>rts", ":write | edit | TSBufEnable highlight<CR>", {silent = true, noremap = true})

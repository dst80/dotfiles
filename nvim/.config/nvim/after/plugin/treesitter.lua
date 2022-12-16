require("nvim-treesitter.install").compilers = { "clang" }

local disable_max_size = 2000000 -- 2MB

local function should_disable(lang, bufnr)
    local size = vim.fn.getfsize(vim.api.nvim_buf_get_name(bufnr or 0))
    -- size will be -2 if it doesn't fit into a number
    if size > disable_max_size or size == -2 then
        return true
    end
    return false
end

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
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm"
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
            disable = should_disable,
            lookahead = true,
            keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
                ["aa"] = "@parameter.outer",
                ["ia"] = "@parameter.inner",
                ["ab"] = "@block.outer",
                ["ib"] = "@block.inner",
                ["al"] = "@loop.outer",
                ["il"] = "@loop.inner",
                ["ai"] = "@conditional.outer",
                ["ii"] = "@conditional.inner",
            },
            include_surrounding_whitespace = false,
        },
        move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
                ["]f"] = "@function.outer",
                ["]c"] = "@class.outer",
                ["]a"] = "@parameter.inner",
                ["]b"] = "@block.outer",
                ["]l"] = "@loop.outer",
                ["]i"] = "@conditional.outer",
            },
            goto_next_end = {
                ["]F"] = "@function.outer",
                ["]C"] = "@class.outer",
                ["]A"] = "@parameter.inner",
                ["]B"] = "@block.outer",
                ["]L"] = "@loop.outer",
                ["]I"] = "@conditional.outer",
            },
            goto_previous_start = {
                ["[f"] = "@function.outer",
                ["[c"] = "@class.outer",
                ["[a"] = "@parameter.inner",
                ["[b"] = "@block.outer",
                ["[l"] = "@loop.outer",
                ["[i"] = "@conditional.outer",
            },
            goto_previous_end = {
                ["[F"] = "@function.outer",
                ["[C"] = "@class.outer",
                ["[A"] = "@parameter.inner",
                ["[B"] = "@block.outer",
                ["[L"] = "@loop.outer",
                ["[I"] = "@conditional.outer",
            },
        },
    },
}

vim.keymap.set(
    "n",
    "<leader>rts",
    ":write | edit | TSBufEnable highlight<CR>",
    { silent = true, noremap = true })

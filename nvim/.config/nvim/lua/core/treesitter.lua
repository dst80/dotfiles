require'nvim-treesitter.configs'.setup {
    ensure_installed = "maintained",
    ignore_install = {
        "dart", "fennel", "fish", "gdscript", "ledger", "nix", "svelte",
        "turtle", "verilog", "zig"
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
    highlight = {enable = true}
}

local keymap = require('core.tools.keymap')
keymap.bind('<leader>rts'):to_command('write | edit | TSBufEnable highlight')

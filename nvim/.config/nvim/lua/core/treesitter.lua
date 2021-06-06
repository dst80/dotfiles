require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  ignore_install = {  "dart", "fennel", "fish", "gdscript", "ledger", "nix", "svelte", "turtle", "verilog", "zig" },
  incremental_selection = {
    enable = true
  },
  indent = {
    enable = true
  },
  highlight = {
    enable = true,
  }
}

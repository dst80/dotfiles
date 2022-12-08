local has_gitsigns, gitsigns = pcall(require, "gitsigns")
if (has_gitsigns) then
    gitsigns.setup({})
end

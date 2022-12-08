local has_neotest, neotest = pcall(require, "neotest")

if (not has_neotest) then
    return
end

neotest.setup({
    adapters = {
        require("neotest-python"),
        require("neotest-dotnet"),
        require("neotest-go"),
        require("neotest-rust"),
    }
})
local options = { noremap = true, silent = true }
vim.keymap.set("n", "<leader>trr",
    function()
        neotest.run.run()
    end, options)
vim.keymap.set("n", "<leader>trf",
    function()
        neotest.run.run(vim.fn.expand("%"))
    end, options)
vim.keymap.set("n", "<leader>trd",
    function()
        neotest.run.run({ strategy = "dap" })
    end, options)
vim.keymap.set("n", "<leader>tst",
    function()
        neotest.run.stop()
    end, options)
vim.keymap.set("n", "<leader>ts",
    function()
        neotest.summary.toggle()
    end, options)

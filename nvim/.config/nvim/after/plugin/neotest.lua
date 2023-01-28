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

local map = function(mode, keys, func, desc)
    if desc then
        desc = 'NeoTest: ' .. desc
    end
    vim.keymap.set(mode, keys, func, { noremap = true, silent = true, desc = desc })
end

map("n", "<leader>trt", function() neotest.run.run() end, '[t]est [r]un nearest [t]est')
map("n", "<leader>trf", function() neotest.run.run(vim.fn.expand("%")) end, '[t]est [r]un [f]ile')
map("n", "<leader>trd", function() neotest.run.run({ strategy = "dap" }) end, '[t]est [r]un [d]ebug')
map("n", "<leader>ta", function() neotest.run.attach() end, '[t]est [a]ttach')
map("n", "<leader>tq", function() neotest.run.stop() end, '[t]est [q]uit/stop')
map("n", "<leader>ts", function() neotest.summary.toggle() end, '[t]est [s]ummary')

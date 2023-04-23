local M = {
    "nvim-neotest/neotest",
    lazy = true,
    event = "BufReadPost",
    dependencies = {
        { "nvim-neotest/neotest-go" },
        { "nvim-neotest/neotest-python" },
        { "nvim-neotest/neotest-vim-test" },
        { "Issafalcon/neotest-dotnet" },
        { "vim-test/vim-test" },
    },
}

function M.run_test()
    require("neotest").run.run()
end

function M.run_test_debug()
    require("neotest").run.run({ strategy = "dap" })
end

function M.run_file()
    require("neotest").run.run(vim.fn.expand("%"))
end

function M.config()
    local has_neotest, neotest = pcall(require, "neotest")
    if not has_neotest then
        return
    end

    neotest.setup({
        adapters = {
            require("neotest-python"),
            require("neotest-dotnet"),
            require("neotest-go"),
            require("neotest-vim-test")({
                ignore_file_types = { "python", "vim", "lua", "go" },
            }),
        },
        icons = {
            failed = "",
            passed = "",
            running = "ﰌ",
        }
    })

    local keymap = require("plugin_keymaps")
    keymap.map("n", keymap.list.test_run_file, M.run_file)
    keymap.map("n", keymap.list.test_run_test, M.run_test)
    keymap.map("n", keymap.list.test_run_test_debug, M.run_test_debug)
    keymap.map("n", keymap.list.test_quit, neotest.run.stop)
    keymap.map("n", keymap.list.test_run_attach, neotest.run.attach)
    keymap.map("n", keymap.list.test_summary, neotest.summary.toggle)
end

return M

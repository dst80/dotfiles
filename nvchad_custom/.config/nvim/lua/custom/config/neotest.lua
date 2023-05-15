local M = {}

M.dependencies = {
  { "nvim-neotest/neotest-go" },
  { "nvim-neotest/neotest-python" },
  { "nvim-neotest/neotest-vim-test" },
  { "Issafalcon/neotest-dotnet" },
  { "vim-test/vim-test" },
}

M.filetype = {
  "python", "go", "cs", "vim", "lua", "cpp", "rust"
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

function M.stop_tests()
  require("neotest").run.stop()
end

function M.run_attach()
  require("neotest").run.attach()
end

function M.toggle_summary()
  require("neotest").run.summary.toggle()
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
    },
  })
end

return M

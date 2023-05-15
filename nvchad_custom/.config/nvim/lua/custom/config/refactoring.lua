local M = {}

M.filetype = {
  "go",
  "c",
  "cpp",
  "java",
  "typescript",
  "javascript",
  "python",
  "lua",
}

M.options = {
  -- prompt for return type
  prompt_func_return_type = {
    go = true,
    java = true,
    cpp = true,
    c = true,
    h = true,
    hpp = true,
    cxx = true,
  },
  -- prompt for function parameters
  prompt_func_param_type = {
    go = true,
    java = true,
    cpp = true,
    c = true,
    h = true,
    hpp = true,
    cxx = true,
  },
}

function M.refactor()
  require("telescope").extensions.refactoring.refactors()
end

function M.config()
  require("refactoring").setup(M.options)

  -- load refactoring Telescope extension
  require("telescope").load_extension("refactoring")
end

return M

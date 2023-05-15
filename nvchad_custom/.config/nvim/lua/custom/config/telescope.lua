local M = {}

M.dependencies = {
  "nvim-lua/plenary.nvim",
}

function M.find_git_repo_or_use_current_dir(current_path)
  local path = require("plenary.path")
  local root_dir = current_path
  for dir in vim.fs.parents(current_path) do
    if vim.fn.isdirectory(tostring(path:new(dir, "/.git"))) == 1 then
      root_dir = dir
      break
    end
  end
  return root_dir
end

function M.search_files()
  require("telescope.builtin").find_files({
    cwd = M.find_git_repo_or_use_current_dir(vim.fn.getcwd()),
    hidden = false,
  })
end

function M.search_hidden_files()
  require("telescope.builtin").find_files({
    cwd = M.find_git_repo_or_use_current_dir(vim.fn.getcwd()),
    hidden = true,
  })
end

function M.search_dotfiles()
  local path = require("plenary.path")
  require("telescope.builtin").find_files({
    cwd = tostring(path:new(vim.fn.getenv("HOME"), "dotfiles")),
    hidden = true,
  })
end

function M.search_buffers()
  require("telescope.builtin").buffers()
end

function M.search_current_buffer_fuzzy_find()
  require("telescope.builtin").current_buffer_fuzzy_find(
    require("telescope.themes").get_dropdown({ winblend = 10, previewer = false })
  )
end

function M.search_occurrences()
  require("telescope.builtin").grep_string()
end

function M.search_word()
  require("telescope.builtin").live_grep()
end

function M.help_tags()
  require("telescope.builtin").help_tags()
end

function M.search_recent_files()
  require("telescope.builtin").oldfiles()
end

function M.config()
  local options = require("plugins.configs.telescope").options
  local telescope = require("telescope")
  telescope.setup(options)
  telescope.load_extension("themes")
  telescope.load_extension("terms")
end

return M

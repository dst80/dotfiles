local M = {}

M.dependencies = {
  { "theHamsta/nvim-dap-virtual-text" },
  { "nvim-telescope/telescope-dap.nvim" },
}

M.filetype = {
  "c",
  "cpp",
  "rust",
  "python",
  "javascript",
  "typescript",
}

function M.get_lldb_path()
  return "/usr/bin/lldb-vscode"
end

M.lldb_config = {
  type = "executable",
  command = M.get_lldb_path,
  name = "lldb",
}

function M.get_program_to_attach()
  return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
end

M.cpp_config = {
  {
    name = "Launch",
    type = "lldb",
    request = "launch",
    program = M.get_program_to_attach,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
    args = {},
  },
}

function M.get_python_environment()
  local cwd = vim.fn.getcwd()
  if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
    return cwd .. "/venv/bin/python"
  elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
    return cwd .. "/.venv/bin/python"
  else
    return "/usr/bin/python"
  end
end

M.python_config = {
  name = "Launch file",
  type = "python",
  request = "launch",
  program = "${file}",
  pythonPath = M.get_python_environment,
}

function M.setup_virtual_text()
  local has_dap_vt, dap_vt = pcall(require, "nvim-dap-virtual-text")
  if not has_dap_vt then
    return
  end
  dap_vt.setup({
    enabled_commands = true,
    highlight_changed_variables = true,
    highlight_new_as_changed = false,
    show_stop_reason = true,
    commented = false,
    only_first_definition = true,
    all_references = false,
    filter_references_pattern = "<module",
    virt_text_pos = "eol",
    all_frames = false,
    virt_lines = false,
    virt_text_win_col = nil,
  })
end

function M.ui_config()
  -- vim.fn.sign_define("DapBreakpoint", { text = " ", texthl = "error", linehl = "", numhl = "" })
  -- vim.fn.sign_define("DapBreakpointCondition", { text = " ", texthl = "error", linehl = "", numhl = "" })
  -- vim.fn.sign_define("DapBreakpointRejected", { text = " ", texthl = "error", linehl = "", numhl = "" })
  -- vim.fn.sign_define("DapLogPoint", { text = " ", texthl = "warning", linehl = "", numhl = "" })
  vim.fn.sign_define("DapBreakpoint", { text = " " })
  vim.fn.sign_define("DapBreakpointCondition", { text = " " })
  vim.fn.sign_define("DapBreakpointRejected", { text = " " })
  vim.fn.sign_define("DapLogPoint", { text = " " })
end

function M.set_telescope_extension()
  local has_telescope, telescope = pcall(require, "telescope")
  if not has_telescope then
    return
  end
  telescope.load_extension("dap")
end

function M.config()
  local has_dap, dap = pcall(require, "dap")
  if not has_dap then
    return
  end

  dap.adapters.lldb = M.lldb_config
  dap.configurations.cpp = M.cpp_config
  dap.configurations.c = dap.configurations.cpp
  dap.configurations.rust = dap.configurations.cpp
  dap.configurations.python = M.python_config

  M.ui_config()
  M.setup_virtual_text()
  M.set_telescope_extension()
end

function M.continue()
  require("dap").continue()
end

function M.step_back()
  require("dap").step_back()
end

function M.step_over()
  require("dap").step_over()
end

function M.step_into()
  require("dap").step_into()
end

function M.step_outo()
  require("dap").step_outo()
end

function M.toggle_breakpoint()
  require("dap").toggle_breakpoint()
end

function M.set_cond_breakpoint()
  require("dap").set_cond_breakpoint()
end

function M.toggle_ui()
  require("dap").toggle_ui()
end

function M.hover()
  require("dap.ui.widgets").hover()
end

function M.show_variables()
  require("dap").variables()
end

function M.run_last()
  require("dap").run_last()
end

function M.show_frames()
  local widgets = require("dap.ui.widgets")
  widgets.centered_float(widgets.frames)
end

function M.show_scopes()
  local widgets = require("dap.ui.widgets")
  widgets.centered_float(widgets.scopes)
end

return M

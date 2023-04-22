local M = {
    "mfussenegger/nvim-dap",
    dependencies = {
        { "theHamsta/nvim-dap-virtual-text" },
        { "nvim-telescope/telescope.nvim" },
        { "nvim-telescope/telescope-dap.nvim" },
    },
    lazy = true,
    filetype = { "c", "cpp", "rust", "python", "javascript", "java" }
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
    }
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

function M.ui_hover()
    require("dap.ui.widgets").hover()
end

function M.ui_preview()
    require("dap.ui.widgets").preview()
end

function M.ui_show_frames()
    local widgets = require("dap.ui.widgets")
    widgets.centered_float(widgets.frames)
end

function M.set_conditional_breakpoint()
    require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
end

function M.ui_config()
    vim.fn.sign_define("DapBreakpoint", { text = " ", texthl = "error", linehl = "", numhl = "" })
    vim.fn.sign_define("DapBreakpointCondition", { text = " ", texthl = "error", linehl = "", numhl = "" })
    vim.fn.sign_define("DapBreakpointRejected", { text = " ", texthl = "error", linehl = "", numhl = "" })
    vim.fn.sign_define("DapLogPoint", { text = " ", texthl = "warning", linehl = "", numhl = "" })
end

function M.set_telescope_extension()
    local has_telescope, telescope = pcall(require, "telescope")
    if not has_telescope then
        return
    end

    telescope.load_extension("dap")
    local keymap = require("plugin_keymaps")
    keymap.map("n", keymap.list.debug_breakpoints_overview, telescope.extensions.dap.list_breakpoints)
    keymap.map("n", keymap.list.debug_commands, telescope.extensions.dap.commands)
    keymap.map("n", keymap.list.debug_preview, telescope.extensions.dap.variables)
    keymap.map("n", keymap.list.debug_frames, telescope.extensions.dap.frames)
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

    local keymap = require("plugin_keymaps");
    keymap.map("n", keymap.list.debug_continue, dap.continue)
    keymap.map("n", keymap.list.debug_step_back, dap.step_back)
    keymap.map("n", keymap.list.debug_step_over, dap.step_over)
    keymap.map("n", keymap.list.debug_step_into, dap.step_into)
    keymap.map("n", keymap.list.debug_step_out, dap.step_out)
    keymap.map("n", keymap.list.debug_toggle_breakpoint, dap.toggle_breakpoint)
    keymap.map_non_silent("n", keymap.list.debug_cond_breakpoint, M.set_conditional_breakpoint)
    keymap.map("n", keymap.list.debug_run_repl, dap.repl.open)
    keymap.map("n", keymap.list.debug_run_last, dap.run_last)
    keymap.map({ "n", "v" }, keymap.list.debug_cond_breakpoint, M.ui_hover)
    keymap.map({ "n", "v" }, keymap.list.debug_preview, M.ui_preview)
    keymap.map("n", keymap.list.debug_frames, M.ui_show_frames)

    M.ui_config()
    M.setup_virtual_text()
    M.set_telescope_extension()
end

return M

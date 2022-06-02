local window_group = vim.api.nvim_create_augroup("WindowCommandGroup", {clear = true})
vim.api.nvim_create_autocmd({"WinEnter", "BufEnter", "InsertLeave"}, { command="lua vim.opt.cursorline = true", group = window_group })
vim.api.nvim_create_autocmd({"WinLeave", "BufLeave", "InsertLeave"}, { command="lua vim.opt.cursorline = false", group = window_group })
vim.api.nvim_create_autocmd({"VimResized"}, { command = "tabdo wimcmd=", group = window_group })
vim.api.nvim_create_autocmd({"FocusGained", "BufEnter"}, { command = "checktime", group = window_group })
vim.api.nvim_create_autocmd({"TextYankPost"}, { command = "silent! lua vim.highlight.on_yank {higroup=\"IncSearch\", timeout=400}", group = window_group })

local general_file_type = vim.api.nvim_create_augroup("GeneralFileType", {clear = true})
vim.api.nvim_create_autocmd("BufWritePre", { command = "%s/\\s\\+$//e", pattern = {"c","cpp","cs","go","rust","lua","python"}, group = general_file_type })


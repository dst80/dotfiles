local keymap = require ("core.keymap_binder")

-- window controls
keymap.bind("<C-l>"):in_mode("n"):to_command("<C-w>l")
keymap.bind("<C-h>"):in_mode("n"):to_command("<C-w>h")
keymap.bind("<C-j>"):in_mode("n"):to_command("<C-w>j")
keymap.bind("<C-k>"):in_mode("n"):to_command("<C-w>k")
keymap.bind("<leader>-"):in_mode("n"):to_command(":vertical resize -5<CR>")
keymap.bind("<leader>+"):in_mode("n"):to_command(":vertical resize +5<CR>")

-- line mover commands
keymap.bind("J"):in_mode("n"):to_command(":m .+1<CR>")
keymap.bind("K"):in_mode("n"):to_command(":m .-2<CR>")
keymap.bind("J"):in_mode("i"):to_command("<Esc>:m .+1<CR>==gi")
keymap.bind("K"):in_mode("i"):to_command("<Esc>:m .-2<CR>==gi")
keymap.bind("J"):in_mode("v"):to_command(":m '>+1<CR>gv=gv")
keymap.bind("K"):in_mode("v"):to_command(":m '<-2<CR>gv=gv")

-- shortcuts for save and close
keymap.bind("<C-q>"):in_mode("n"):to_command(":wq<CR>")
keymap.bind("<C-s>"):in_mode("n"):to_command(":w<CR>")
keymap.bind("<C-q>"):in_mode("i"):to_command("<Esc>:wq<CR>")
keymap.bind("<C-s>"):in_mode("i"):to_command("<Esc>:w<CR>")

-- LSP shortcuts
keymap.bind("gD"):to_lua_command("vim.lsp.buf.declaration()")
keymap.bind("gd"):to_lua_command("vim.lsp.buf.definition()")
keymap.bind("gi"):to_lua_command("vim.lsp.buf.implementation()")
keymap.bind("gr"):to_lua_command("vim.lsp.buf.references()")
keymap.bind("<C-K>"):to_lua_command("vim.lsp.buf.hover()")
keymap.bind("<C-H>"):to_lua_command("vim.lsp.buf.signature_help()")
keymap.bind("<leader>wa"):to_lua_command("vim.lsp.buf.add_workspace_folder()")
keymap.bind("<leader>wr"):to_lua_command("vim.lsp.buf.remove_workspace_folder()")
keymap.bind("<leader>wl"):to_lua_command("print(vim.inspect(vim.lsp.buf.list_workspace_folders()))")
keymap.bind("<leader>D"):to_lua_command("vim.lsp.buf.type_definition()")
keymap.bind("<leader>rn"):to_lua_command("vim.lsp.buf.rename()")
keymap.bind("<leader>ca"):to_lua_command("vim.lsp.buf.code_action()")
keymap.bind("<leader>sd"):to_lua_command("vim.lsp.diagnostic.show_line_diagnostics()")
keymap.bind("<leader>gpd"):to_lua_command("vim.lsp.diagnostic.goto_prev()")
keymap.bind("<leader>gnd"):to_lua_command("vim.lsp.diagnostic.goto_next()")
keymap.bind("<leader>ll"):to_lua_command("vim.lsp.diagnostic.set_loclist()")
keymap.bind("<leader>fo"):to_lua_command("vim.lsp.buf.formatting()")

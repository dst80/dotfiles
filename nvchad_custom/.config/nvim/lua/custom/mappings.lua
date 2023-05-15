local mapping = {}

mapping.disabled = {
  n = {
    ["<ESC>"] = "",
    ["<F1>"] = "",
    ["<C-k>"] = "",
    ["<C-j>"] = "",

    -- line numbers
    ["<leader>n"] = "",
    ["<leader>rn"] = "",

    -- disable default telescope keybindings
    ["<leader>ff"] = "",
    ["<leader>fa"] = "",
    ["<leader>fw"] = "",
    ["<leader>fb"] = "",
    ["<leader>fh"] = "",
    ["<leader>fo"] = "",
    ["<leader>fz"] = "",

    -- disable lsp default keybindings
    ["<leader>ls"] = "",
    ["<leader>ra"] = "",
  },
}

mapping.general = {
  n = {
    ["<ESC>"] = { ":noh <CR>", "clear highlights", opts = { silent = true } },
    -- window handling
    ["<C-Left>"] = { "<C-w>h", "window left" },
    ["<C-Right>"] = { "<C-w>l", "window right" },
    ["<C-Down>"] = { "<C-w>j", "window down" },
    ["<C-Up>"] = { "<C-w>k", "window up" },

    ["<C-d>"] = { "<C-d>zz", "Move page down and center cursor", opts = { silent = true } },
    ["<PageDown>"] = { "<C-d>zz", "Move page down and center cursor", opts = { silent = true } },
    ["<C-u>"] = { "<C-u>zz", "Move page up to center cursor", opts = { silent = true } },
    ["<PageUp>"] = { "<C-u>zz", "Move page up to center cursor", opts = { silent = true } },

    -- line numbers
    ["<leader>tno"] = { "<cmd> set nu! <CR>", "toggle line number", opts = { silent = true } },
    ["<leader>trn"] = { "<cmd> set rnu! <CR>", "toggle relative number", opts = { silent = true } },
    ["J"] = { "mzJ`z", "Merge line and keep cursor on the front" },
    ["n"] = { "nzzzv", "center jump to next found element" },
    ["N"] = { "nzzzv", "center jump to previous found element" },

    -- line mover commands
    ["<A-j>"] = { "<Cmd>m .+1<CR>==", "move current line down", opts = { silent = true } },
    ["<A-k>"] = { "<Cmd>m .-2<CR>==", "move current line up", opts = { silent = true } },
    ["<A-Down>"] = { "<Cmd>m .+1<CR>==", "move current line down", opts = { silent = true } },
    ["<A-Up>"] = { "<Cmd>m .-2<CR>==", "move current line up", opts = { silent = true } },

    ["<C-x><C-x>"] = { [[:bd!<CR>]], "close buffer without saving", opts = { silent = true } },
    ["<C-q><C-q>"] = { [[:w<CR>:bd<CR>]], "fast save and close buffer", opts = { silent = true } },

    ["<leader>rp"] = { [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], "search/replace word under cursor" },
  },

  i = {
    -- line mover commands
    ["<A-j>"] = { "<ESC><CMD>m .+1<CR>==gi", "move current line down", opts = { silent = true } },
    ["<A-k>"] = { "<ESC><CMD>m .-2<CR>==gi", "move current line up", opts = { silent = true } },
    ["<A-Down>"] = { "<ESC><CMD>m .+1<CR>==gi", "move current line down", opts = { silent = true } },
    ["<A-Up>"] = { "<ESC><CMD>m .-2<CR>==gi", "move current line up", opts = { silent = true } },
  },

  v = {
    -- line mover commands
    ["<A-j>"] = { ":m '>+1<CR>gv=gv", "move current line down", opts = { silent = true } },
    ["<A-k>"] = { ":m '<-2<CR>gv=gv", "move current line up", opts = { silent = true } },
    ["<A-Down>"] = { ":m '>+1<CR>gv=gv", "move current line down", opts = { silent = true } },
    ["<A-Up>"] = { ":m '<-2<CR>gv=gv", "move current line up", opts = { silent = true } },

    -- easier indent in visual mode, because it will stay in indent mode
    ["<"] = { "<gv", "keeps selection for another un indent", opts = { silent = true } },
    [">"] = { ">gv", "keeps selection for another indent", opts = { silent = true } },
  },
}

mapping.lspconfig = {
  n = {
    ["<C-k>"] = { vim.lsp.buf.signature_help, "lsp signature_help" },
    ["<leader>rn"] = { require("custom.config.lsp").rename, "rename word" },
    ["<leader>rf"] = { require("custom.config.lsp").format, "format file" },
  },
}

mapping.rust_tools = {
  n = {
    ["<leader>ra"] = { require("custom.config.rust-tools").hover_actions },
  },
}

mapping.clangd_extensions = {
  n = {
    ["<leader>ht"] = { ":ClangdSwitchSourceHeader<cr>", "header/source toggle" },
  },
}

mapping.refactoring = {
  v = {
    ["<leader>rr"] = { require("custom.config.refactoring").refactor, "refactor selection" },
  },
}

local telescope = require("custom.config.telescope")
mapping.telescope = {
  plugin = true,

  n = {
    ["<leader>sf"] = { telescope.search_files, "search files" },
    ["<leader>sa"] = { telescope.search_hidden_files, "search all" },
    ["<leader>sx"] = { telescope.search_dotfiles, "search in dotfiles" },
    ["<leader>so"] = { telescope.search_occurrences, "search all occurrences" },
    ["<leader>sw"] = { telescope.search_word, "search word" },
    ["<leader>sb"] = { telescope.search_buffers, "search buffers" },
    ["<leader>sh"] = { telescope.help_tags, "search help tags" },
    ["<leader>sr"] = { telescope.search_recent_files, "search recent files" },
    ["<leader>sc"] = { telescope.search_current_buffer_fuzzy_find, "search in current buffer" },

    -- git
    -- ["<leader>cm"] = { "<cmd> Telescope git_commits <CR>", "git commits" },
    -- ["<leader>gt"] = { "<cmd> Telescope git_status <CR>", "git status" },

    -- pick a hidden term
    ["<leader>pt"] = { "<cmd> Telescope terms <CR>", "pick hidden term" },

    -- theme switcher
    ["<leader>th"] = { "<cmd> Telescope themes <CR>", "nvchad themes" },
  },
}

local dap_config = require("custom.config.dap")
mapping.dap = {
  n = {
    ["<leader>dr"] = { dap_config.run_last, "debug run last" },
    ["<leader>dc"] = { dap_config.continue, "debug continue" },
    ["<leader>du"] = { dap_config.step_back, "debug undo last step (step back) " },
    ["<leader>dn"] = { dap_config.step_over, "debug next step (step over)" },
    ["<leader>di"] = { dap_config.step_into, "debug into" },
    ["<leader>do"] = { dap_config.step_outo, "debug outo" },
    ["<leader>db"] = { dap_config.toggle_breakpoint, "debug toggle breakpoint" },
    ["<leader>dz"] = { dap_config.set_cond_breakpoint, "debug conditional breakpoint" },
    ["<leader>dt"] = { dap_config.toggle_ui, "debug toggle ui" },
    ["<leader>dv"] = { dap_config.show_variables, "debug show variables" },
    ["<leader>dh"] = { dap_config.hover, "debug hover" },
    ["<leader>df"] = { dap_config.show_frames, "debug show frames" },
    ["<leader>ds"] = { dap_config.show_scopes, "debug show scopes" },
  },
}

local neotest = require("custom.config.neotest")
mapping.neotest = {
  n = {
    ["<leader>tf"] = { neotest.run_file, "test all tests in file" },
    ["<leader>tr"] = { neotest.run_test, "test nearest test" },
    ["<leader>td"] = { neotest.run_test_debug, "test in debug" },
    ["<leader>ta"] = { neotest.run_attach, "test attach" },
    ["<leader>ts"] = { neotest.stop_tests, "stop tests" },
    ["<leader>to"] = { neotest.toggle_summary, "test overview summary" },
  },
}

return mapping

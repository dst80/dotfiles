local M = {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/popup.nvim",
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
        "nvim-telescope/telescope-ui-select.nvim",
        "nvim-tree/nvim-web-devicons",
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build =
            "cmake -S . -B build -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
        },
        lazy = true,
        cmd = "Telescope"
    },
}

M.options = {
    defaults = {
        vimgrep_arguments = {
            "rg",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--hidden",
            "--ignore",
            "--glob=!.git"
        },
        file_sorter = require("telescope.sorters").get_fuzzy_file,
        generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
        buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
        file_ignore_patterns = { "node_modules" },
        -- telescope view
        layout_strategy = "horizontal",
        layout_config = {
            horizontal = {
                prompt_position = "bottom",
                preview_width = 0.55,
                results_width = 0.8,
            },
            vertical = {
                mirror = false,
            },
            width = 0.87,
            height = 0.80,
            preview_cutoff = 120,
        },
        hidden = true,
        prompt_prefix = "  ",
        color_devicons = true,
        selection_caret = "  ",
        entry_prefix = "  ",
        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "ascending",
        path_display = { "truncate" },
        winblend = 0,
        border = {},
        borderchars = { " ", " ", " ", " ", " ", " ", " ", " " },
        set_env = { ["COLORTERM"] = "truecolor" },
        mappings = {
            n = { ["q"] = require("telescope.actions").close },
        },
    },
    pickers = {
        buffers = {
            theme = "dropdown",
            previewer = false,
        }
    },
    extensions = {
        fzf_native = {
            override_generic_sorter = false,
            override_file_sorter = true
        },
        ["ui-select"] = {
            require("telescope.themes").get_dropdown {
            }
        }
    }
}

function M.find_git_repo_or_use_current_dir(current_path)
    local path = require("plenary.path")
    local root_dir = current_path
    for dir in vim.fs.parents(current_path) do
        if (vim.fn.isdirectory(tostring(path:new(dir, "/.git"))) == 1) then
            root_dir = dir
            break
        end
    end
    return root_dir
end

function M.search_file()
    require("telescope.builtin").find_files({
        cwd = M.find_git_repo_or_use_current_dir(vim.fn.getcwd()),
        hidden = false
    })
end

function M.find_hidden_files()
    require("telescope.builtin").find_files({
        cwd = M.find_git_repo_or_use_current_dir(vim.fn.getcwd()),
        hidden = true
    })
end

function M.search_dotfiles()
    local path = require("plenary.path")
    require("telescope.builtin").find_files({
        cwd = tostring(path:new(vim.fn.getenv("HOME"), "dotfiles")),
        hidden = true
    })
end

function M.fuzzy_search_buffer()
    require("telescope.builtin").current_buffer_fuzzy_find(
        require("telescope.themes").get_dropdown({ winblend = 10, previewer = false }))
end

function M.config()
    require("telescope").setup(M.options)

    require("telescope").load_extension("fzf")
    require("telescope").load_extension("ui-select")

    local keymap = require("plugin_keymaps")
    keymap.map("n", keymap.list.search_file, M.search_file)
    keymap.map("n", keymap.list.search_dotfiles, M.search_dotfiles)
    keymap.map("n", keymap.list.search_hidden_file, M.find_hidden_files)
    keymap.map("n", keymap.list.search_fuzzy_buffer, M.fuzzy_search_buffer)
    keymap.map("n", keymap.list.search_help, require("telescope.builtin").help_tags)
    keymap.map("n", keymap.list.search_word, require("telescope.builtin").grep_string)
    keymap.map("n", keymap.list.search_by_grep, require("telescope.builtin").live_grep)
    keymap.map("n", keymap.list.search_old_file, require("telescope.builtin").oldfiles)
    keymap.map("n", keymap.list.show_buffer_overview, require("telescope.builtin").buffers)
    keymap.map("n", keymap.list.show_diagnostics_overview, require("telescope.builtin").diagnostics)
end

return M

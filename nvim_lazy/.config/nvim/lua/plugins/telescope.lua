local M = {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/popup.nvim",
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
        "nvim-telescope/telescope-ui-select.nvim",
        'nvim-tree/nvim-web-devicons',
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build =
            "cmake -S . -B build -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
        },
        lazy = true,
        cmd = "Telescope"
    },
}

local options = {
    defaults = {
        vimgrep_arguments = {
            "rg",
            "-L",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
        },
        -- Developer configurations: Not meant for general override
    },
}


function M.config()
    require('telescope').setup {
        defaults = {
            vimgrep_arguments = {
                'rg',
                '--no-heading',
                '--with-filename',
                '--line-number',
                '--column',
                '--smart-case',
                '--hidden',
                '--ignore',
                '--glob=!.git'
            },
            file_sorter = require('telescope.sorters').get_fuzzy_file,
            generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
            file_previewer = require('telescope.previewers').vim_buffer_cat.new,
            grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
            qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
            buffer_previewer_maker = require('telescope.previewers').buffer_previewer_maker,
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
            prompt_prefix = '  ',
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
            set_env = { ['COLORTERM'] = 'truecolor' },
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

    require('telescope').load_extension('fzf')
    require('telescope').load_extension('ui-select')

    local path = require('plenary.path')
    local function find_git_repo_or_use_current_dir(current_path)
        local root_dir = current_path
        for dir in vim.fs.parents(current_path) do
            if (vim.fn.isdirectory(tostring(path:new(dir, "/.git"))) == 1) then
                root_dir = dir
                break
            end
        end
        return root_dir
    end

    vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] find recently opened files' })

    vim.keymap.set('n', '<leader>/', function()
        require('telescope.builtin')
            .current_buffer_fuzzy_find(require('telescope.themes')
                .get_dropdown { winblend = 10, previewer = false })
    end, { desc = '[/] fuzzily search in current buffer]' })

    vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[s]earch [h]elp' })
    vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[s]earch current [w]ord' })
    vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[s]earch by [g]rep' })
    vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[s]earch [d]iagnostics' })
    vim.keymap.set("n", "<leader>sb", require('telescope.builtin').buffers, { desc = '[s]witch [b]uffer' })

    vim.keymap.set("n", "<leader>sf", function()
        require('telescope.builtin')
            .find_files({ cwd = find_git_repo_or_use_current_dir(vim.fn.getcwd()), hidden = false })
    end, { desc = '[s]earch [f]ile' })

    vim.keymap.set("n", "<leader>shf", function()
        require('telescope.builtin')
            .find_files({ cwd = find_git_repo_or_use_current_dir(vim.fn.getcwd()), hidden = true })
    end, { desc = '[s]earch [h]idden [f]ile' })

    vim.keymap.set("n", "<leader>df", function()
        require('telescope.builtin')
            .find_files({ cwd = tostring(path:new(vim.fn.getenv('HOME'), 'dotfiles')), hidden = true })
    end, { desc = '[d]ot [f]iles' })
end

return M

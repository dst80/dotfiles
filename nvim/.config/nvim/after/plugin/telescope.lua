require('telescope').setup {
    defaults = {
        file_sorter = require('telescope.sorters').get_fzy_sorter,

        file_previewer = require('telescope.previewers').vim_buffer_cat.new,
        grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
        qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
        buffer_previewer_maker = require('telescope.previewers').buffer_previewer_maker,
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
        hidden = true,
        prompt_prefix = '  :',
        color_devicons = true,
        set_env = { ['COLORTERM'] = 'truecolor' }
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
require('telescope').load_extension('dotfiles')
require('telescope').load_extension('file_browser')
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
vim.keymap.set("n", "<leader>fb", require('telescope').extensions.file_browser.file_browser,
    { desc = '[f]ile [b]rowser]' })

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

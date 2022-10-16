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

local options = { silent = true, noremap = true }
vim.keymap.set("n", "<leader>fb", require('telescope').extensions.file_browser.file_browser, options)
vim.keymap.set("n", "<leader>h", require('telescope.builtin').help_tags, options)
vim.keymap.set("n", "<leader>fd", require('telescope.builtin').diagnostics, options)
vim.keymap.set("n", "<leader>sb", require('telescope.builtin').buffers, options)

vim.keymap.set("n", "<leader>ff", function()
    require('telescope.builtin').find_files({
        cwd = find_git_repo_or_use_current_dir(vim.fn.getcwd()),
        hidden = false
    })
end, options)

vim.keymap.set("n", "<leader>fhf", function()
    require('telescope.builtin').find_files({
        cwd = find_git_repo_or_use_current_dir(vim.fn.getcwd()),
        hidden = true,
    })
end, options)

vim.keymap.set("n", "<leader>df", function()
    require('telescope.builtin').find_files({
        cwd = tostring(path:new(vim.fn.getenv('HOME'), 'dotfiles')),
        hidden = true
    })
end, options)


vim.keymap.set("n", "<leader>fg", require('telescope.builtin').live_grep, options)

vim.keymap.set("n", "<leader>fw", function()
    require('telescope.builtin').grep_string({ search = vim.fn.expand("<cword>") })
end, options)

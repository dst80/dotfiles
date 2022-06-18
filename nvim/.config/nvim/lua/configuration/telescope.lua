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
        prompt_prefix = ' ',
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


local options = { silent = true, noremap = true }
vim.keymap.set("n", "<leader>gf", require('telescope.builtin').git_files, options)
vim.keymap.set("n", "<leader>ff", require('telescope.builtin').find_files, options)
vim.keymap.set("n", "<leader>fg", require('telescope.builtin').live_grep, options)
vim.keymap.set("n", "<leader>fb", require('telescope').extensions.file_browser.file_browser, options)
vim.keymap.set("n", "<leader>h", require('telescope.builtin').help_tags, options)
vim.keymap.set("n", "<leader>dt", require('telescope.builtin').diagnostics, options)

vim.keymap.set("n", "<leader>sb", require('telescope.builtin').buffers, options)

vim.keymap.set("n", "<leader>cfg", function()
    require('telescope.builtin').find_files({ cwd = vim.fn.stdpath('config') })
end, options)

vim.keymap.set("n", "<leader>df", function()
    require('telescope.builtin').git_files({ cwd = (vim.fn.getenv('HOME') .. '/dotfiles') })
end, options)

vim.keymap.set("n", "<leader>fs", function()
    require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For->") })
end, options)

vim.keymap.set("n", "<leader>fw", function()
    require('telescope.builtin').grep_string({ search = vim.fn.expand("<cword>") })
end, options)

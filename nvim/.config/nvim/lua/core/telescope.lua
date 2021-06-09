require('telescope').setup{
  defaults = {
    file_sorter = require('telescope.sorters').get_fzy_sorter,

    file_previewer   = require('telescope.previewers').vim_buffer_cat.new,
    grep_previewer   = require('telescope.previewers').vim_buffer_vimgrep.new,
    qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
    buffer_previewer_maker = require('telescope.previewers').buffer_previewer_maker,
    vimgrep_arguments = {
      'rg',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case'
    },

    prompt_prefix = '🔍',
    color_devicons = true,
    set_env = { ['COLORTERM'] = 'truecolor' },
  },
  extensions = {
    fzy_native = {
      override_generic_sorter = false,
      override_file_sorter = true,
    }
  }
}

require('telescope').load_extension('fzy_native')
require('telescope').load_extension('dotfiles')

local keymap = require ("core.tools.keymap")

keymap.bind("<leader>gf"):to_lua_command("require('telescope.builtin').git_files()")
keymap.bind("<leader>gb"):to_lua_command("require('telescope.builtin').git_branches()")
keymap.bind("<leader>ggc"):to_lua_command("require('telescope.builtin').git_commits()")
keymap.bind("<leader>ff"):to_lua_command("require('telescope.builtin').find_files()")
keymap.bind("<leader>fg"):to_lua_command("require('telescope.builtin').live_grep()")
keymap.bind("<leader>fb"):to_lua_command("require('telescope.builtin').buffers()")
keymap.bind("<leader>fh"):to_lua_command("require('telescope.builtin').help_tags()")

keymap.bind("<leader>ps"):to_lua_command("require('telescope.builtin').grep_string({ search = vim.fn.input(\"Grep For->\")})")
keymap.bind("<leader>pw"):to_lua_command("require('telescope.builtin').grep_string({search=vim.fn.expand(\"<cword>\")})")

keymap.bind("<leader>vrc"):to_command(":Telescope dotfiles path=" ..os.getenv("HOME").."/dotfiles<CR>")


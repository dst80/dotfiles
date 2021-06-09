if not pcall(require, 'completion') then
  return
end

local keymap = require('core.tools.keymap')
keymap.bind('<c-p>'):in_mode('i'):with_remapping():as_plug_command('completion_trigger')
keymap.bind('<Tab>'):in_mode('i'):with_remapping():as_plug_command('completion_smart_tab')
keymap.bind('<S-Tab>'):in_mode('i'):with_remapping():as_plug_command('completion_smart_s_tab')

local options = require('core.tools.options')
options:set_option('completeopt', {'menuone','noinsert','noselect'})
options:add_option('shortmess', 'c')

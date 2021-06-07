local key_binding = {}

function key_binding:new()
  local instance = {
    key_binding_string = "",
    command_string = "",
    mode = "",
    options = {
      noremap = true,
      silent = true,
      expr = false,
      nowait = false,
    }
  }
  setmetatable(instance,self)
  self.__index = self
  return instance
end

function key_binding:execute_mapping()
  vim.api.nvim_set_keymap (self.mode, self.key_binding_string, self.command_string, self.options)
end

function key_binding:bind(key_string)
  self.key_binding_string = key_string
  return self
end

function key_binding:in_mode(mode_string)
  self.mode = mode_string
  return self
end

function key_binding:mode(mode_string)
  self.mode = mode_string
end

function key_binding:not_silent()
  self.options.silent = false
  return self
end

function key_binding:can_remap()
  self.options.noremap = false
  return self
end

function key_binding:expression()
  self.options.expr = true
  return self
end

function key_binding:no_wait()
  self.options.nowait = true
  return self
end

function key_binding:to_command(command_string)
  self.command_string = (":%s<CR>"):format(command_string)
  self:execute_mapping ()
end

function key_binding:to_lua_command(command_string)
  self.command_string = (":lua %s<CR>"):format(command_string)
  self.mode = "n"
  self.options.noremap = true
  self.options.silent = true
  self:execute_mapping ()
end



local pbind = {}

function pbind.bind(key_string)
  local kb = key_binding:new()
  return kb:bind (key_string)
end

return pbind

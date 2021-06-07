local pbind = {}

function pbind:set_global_option(option, value)
    vim.o[option] = value
end

function pbind:set_global_options(options)
  for option, value in pairs(options) do
    self:set_global_option(option, value)
  end
end 

function pbind:is_boolean(value)
    return value == true or value == false
end

function pbind:set_buffer_option(option, value)
  if self:is_boolean(value) then
    vim.cmd('set ' .. option)
  else
    vim.cmd('set ' .. option .. '=' .. value)
  end
end  

function pbind:set_buffer_options(options)
  for option, value in pairs(options) do
    self:set_buffer_option(option,value)
  end
end

return pbind
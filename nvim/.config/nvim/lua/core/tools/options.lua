local pbind = {}

function pbind:set_option(option, value)
  vim.opt[option] = value
end

function pbind:set_global_option(option, value)
  vim.go[option] = value
end

function pbind:set_local_option(option, value)
  vim.bo[option] = value
end

function pbind:set_window_option(option, value)
  vim.wo[option] = value
end

function pbind:set_options(options)
  for option, value in pairs(options) do
    self:set_option(option, value)
  end
end

function pbind:set_global_options(options)
  for option, value in pairs(options) do
    self:set_global_option(option, value)
  end
end

function pbind:set_local_options(options)
  for option, value in pairs(options) do
    self:set_local_option(option, value)
  end
end


function pbind:set_window_options(options)
  for option, value in pairs(options) do
    self:iset_window_option(option, value)
  end
end

function pbind:add_option(option, value)
  vim.opt[option]:append(value)
end

return pbind

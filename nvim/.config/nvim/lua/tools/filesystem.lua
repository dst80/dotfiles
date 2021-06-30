local filesystem = {}

function filesystem:get_system_name()
    local system_name = vim.loop.os_uname().sysname;
    if system_name == 'Linux' or system_name == 'Darwin' then
        return system_name
    end
    return 'Windows'
end

function filesystem:init()
    self.system_name = self.get_system_name()
    self.path_sep = (self.get_system_name() == 'Windows') and '\\' or '/'
    self.__index = self
end

function filesystem:join_path(...)
    local path_sep = (filesystem:get_system_name() == 'Windows') and '\\' or '/'
    return table.concat(vim.tbl_flatten {...}, path_sep)
end

filesystem:init()

return filesystem

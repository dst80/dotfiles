local fs = require('tools.filesystem')
local global = {}

function global:load_variables()
    local system_name = fs.system_name
    self.is_mac = system_name == 'Darwin'
    self.is_linux = system_name == 'Linux'
    self.is_windows = system_name == 'Windows'
    self.home = self:get_home_dir ()
    self.data_dir = vim.fn.stdpath('data')
    self.vim_path = vim.fn.stdpath('config')
    self.cache_dir = fs.join_path(home, '.cache', 'nvim')
    self.modules_dir = fs.join_path(self.vim_path, 'modules')
    self.site_dir = fs.join_path(self.data_dir, 'site')
end

function global:get_home_dir ()
    if 'Windows' == fs.system_name then
        return os.getenv("USERPROFILE")
    end
    return os.getenv("HOME")
end


global:load_variables()

return global

local global = {}
local home = global.is_windows and os.getenv("USERPROFILE") or os.getenv("HOME")
local path_sep = global.is_windows and '\\' or '/'
local os_name = vim.loop.os_uname().sysname

function global:load_variables()
    self.is_mac = os_name == 'Darwin'
    self.is_linux = os_name == 'Linux'
    self.is_windows = os_name == 'Windows'
    self.vim_path = vim.fn.stdpath('config')
    self.cache_dir = home .. path_sep .. '.cache' .. path_sep .. 'nvim' ..
                         path_sep
    self.modules_dir = self.vim_path .. path_sep .. 'modules'
    self.path_sep = path_sep
    self.home = home
    self.data_dir = vim.fn.stdpath('data')
    self.site_dir = self.data_dir .. self.path_sep .. 'site'
end

global:load_variables()

return global

local globals = require ('global')

local sumneko = {}

function sumneko:init ()
    self.root = globals.data_dir .. "/site/pack/lua-language-server"
    self.binary = globals.is_linux and
        self.root .. "/bin/Linux/lua-language-server" or
        self.root .. "/bin/Windows/lua-language-server"
end

function sumneko:install ()
    if globals.is_linux then
        os.execute(globals.vim_path .. "/install.sh")
    else
        os.execute(globals.vim_path .. "/install.bat")
    end
end

sumneko:init ()

return sumneko

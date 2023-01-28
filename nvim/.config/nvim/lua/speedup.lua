-- Disable some builtin vim plugins
local disabled_built_ins = {
    "2html_plugin",
    "getscript",
    "getscriptPlugin",
    "gzip",
    "logipat",
    "netrw",
    "netrwPlugin",
    "netrwSettings",
    "netrwFileHandlers",
    "matchit",
    "matchparen",
    "tar",
    "tarPlugin",
    "rrhelper",
    "vimball",
    "vimballPlugin",
    "zip",
    "zipPlugin",
}

for _, plugin in pairs(disabled_built_ins) do
    vim.g["loaded_" .. plugin] = 1
end

_G.__luacache_config = {
    chunks = {
        enable = true,
        path = vim.fn.stdpath('cache') .. '/luacache_chunks',
    },
    modpaths = {
        enable = true,
        path = vim.fn.stdpath('cache') .. '/luacache_modpaths',
    }
}
require('impatient')

-- Install packer
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = ' '

require('config').setup()
require('lazy').setup('plugins', {
    change_detection = {
        enabled = false,
        notify = false,
    }
})
require('keymap').setup()
require('diagnostics').setup()
require('autocommands').setup()

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

require("lazy").setup({
    {
        "kylechui/nvim-surround",
        config = true,
    },
})

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

vim.g.mapleader = " "
vim.g.maplocalleader = " "

map("n", "<Space>", "<Nop>", opts)

map("n", "<leader><space>", ":nohlsearch<CR>", opts)
map("n", "<leader>x", ":source %<CR>", opts)
map("n", "gr", ":<cmd>call VSCodeCall('editor.action.goToReference')<CR>", opts)
map("n", "<leader>fg", ":<cmd>call VSCodeCall('workbench.action.findInFiles')<CR>", opts)
map("n", "<leader>fd", ":<cmd>call VSCodeCall('workbench.actions.view.problems')<CR>", opts)
map("n", "<leader>ca", ":<cmd>call VSCodeCall('editor.action.refactor')<CR>", opts)

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

vim.g.mapleader = " "
vim.g.maplocalleader = " "

map("i", "jj", "<Esc>", opts)
map("n", "<Space>", "<Nop>", opts)

map("n", "<leader><space>", ":nohlsearch<CR>", opts)
map("n", "<leader>x", ":source %<CR>", opts)

map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)

-- nvim-tree
map("n", "<F7>", ":NvimTreeToggle<CR>", opts)

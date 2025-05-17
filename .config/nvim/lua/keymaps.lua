local map = vim.keymap.set
local opts = { noremap = true, silent = true }

vim.g.mapleader = " "
vim.g.maplocalleader = " "

map("i", "jj", "<Esc>", opts)
map("n", "<space>", "<Nop>", opts)

map("n", "<leader><space>", ":nohlsearch<CR>", opts)
map("n", "<leader><leader>x", ":source %<CR>", opts)
map("n", "<leader>x", ":.lua<CR>", opts)
map("v", "<leader>x", ":lua<CR>", opts)

map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)

map("n", "<M-j>", "<cmd>execute 'move .+' .. v:count1<CR>==", opts)
map("n", "<M-k>", "<cmd>execute 'move .-' .. (v:count1 + 1)<CR>==", opts)

map("i", "<C-u>", "<Cmd>lua require('luasnip.extras.select_choice')()<CR>", opts)

-- English IPA
map("i", "<C-v>dd", "ɾ", opts)
map("i", "<C-v>eh", "ə", opts)
map("i", "<C-v>ee", "ɜː", opts)
map("i", "<C-v>ae", "æ", opts)
map("i", "<C-v>ah", "ʌ", opts)
map("i", "<C-v>aa", "ɑː", opts)
map("i", "<C-v>oh", "ɒ", opts)
map("i", "<C-v>oo", "ɔː", opts)
map("i", "<C-v>uh", "ʊ", opts)
map("i", "<C-v>uu", "uː", opts)
map("i", "<C-v>ih", "ɪ", opts)
map("i", "<C-v>ii", "iː", opts)
map("i", "<C-v>ng", "ŋ", opts)
map("i", "<C-v>th", "θ", opts)
map("i", "<C-v>dh", "ð", opts)
map("i", "<C-v>sh", "ʃ", opts)
map("i", "<C-v>zh", "ʒ", opts)

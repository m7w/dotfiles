local opt = vim.opt
local api = vim.api

opt.undofile = true
opt.history = 100
opt.termguicolors = true
opt.cursorline = true
opt.mouse = "nivh"

opt.updatetime = 750

opt.wildignore:append({ "*.o", "*.pyc", "*.pyo", "*.class" })
opt.wildignore:append({ "*.swp", "*.swo" })
opt.wildignore:append({ "*/bin/*", "*/build/*", "*/target/*" })

opt.colorcolumn = "100"
opt.textwidth = 100
opt.showbreak = "↳"
opt.list = true
opt.listchars = {
  tab = "⟫ ",
  trail = "▫",
  nbsp = "˽",
}
opt.fillchars = {
  foldopen = "",
  foldclose = "",
  fold = " ",
  foldsep = " ",
}

opt.keymap = "russian-jcukenwin"
opt.iminsert = 0

opt.smoothscroll = true

opt.foldcolumn = "auto"
opt.foldminlines = 2
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldenable = false
opt.foldtext = ""

opt.shiftwidth = 4
opt.softtabstop = 4
opt.tabstop = 4
opt.expandtab = true

-- Salesforce filetypes
vim.filetype.add({
  extension = {
    page = "visualforce",
    apex = "apex",
    cls = "apex",
    trigger = "apex",
    cmp = "html",
  },
})

vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
vim.g.skip_ts_context_commentstring_module = true
-------------------------------------------------------
-- tab size for html, css, xml, js, ts, jsx, vue, json files
-------------------------------------------------------
api.nvim_create_autocmd("FileType", {
  pattern = {
    "xml",
    "html",
    "css",
    "json",
    "javascript",
    "typescript",
    "javascriptreact",
    "typescriptreact",
    "vue",
    "svelte",
  },
  group = api.nvim_create_augroup("tabwidth-2", { clear = true }),
  command = "setlocal shiftwidth=2 softtabstop=2 tabstop=2 expandtab",
})

api.nvim_create_autocmd("FileType", {
  pattern = {
    "text",
    "markdown",
  },
  group = api.nvim_create_augroup("spell-check", { clear = true }),
  command = "setlocal spell",
})

opt.number = true
opt.relativenumber = true
-- api.nvim_create_augroup("rnu_toggle", { clear = true })
-- api.nvim_create_autocmd({ "BufEnter", "WinEnter", "FocusGained", "InsertLeave" }, {
-- 	pattern = "*",
-- 	group = "rnu_toggle",
-- 	callback = function()
-- 		local insmode = api.nvim_get_mode().mode == "i"
-- 		local toggleterm = vim.bo.filetype == "toggleterm"
-- 		local float = api.nvim_win_get_config(0).zindex
-- 		if opt.number and not (insmode or toggleterm or float) then
-- 			opt.relativenumber = true
-- 		end
-- 	end,
-- })
-- api.nvim_create_autocmd({ "BufLeave", "WinLeave", "FocusLost", "InsertEnter" }, {
-- 	group = api.nvim_create_augroup("rnu_toggle", { clear = true }),
-- 	callback = function()
-- 		if opt.number then
-- 			opt.relativenumber = false
-- 		end
-- 	end,
-- })
vim.cmd([[
  highlight Normal guibg=none
  highlight NonText guibg=none
  highlight Normal ctermbg=none
  highlight NonText ctermbg=none
]])

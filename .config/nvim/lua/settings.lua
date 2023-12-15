local opt = vim.opt
local api = vim.api

opt.history = 100
opt.termguicolors = true
opt.mouse = "nivh"

opt.wildignore:append({ "*.o", "*.pyc", "*.pyo", "*.class" })
opt.wildignore:append({ "*.swp", "*.swo" })
opt.wildignore:append({ "*/bin/*", "*/build/*", "*/target/*" })

opt.colorcolumn = "100"
opt.showbreak = "↳"

opt.foldminlines = 5
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldenable = false

opt.shiftwidth = 4
opt.softtabstop = 4
opt.tabstop = 4
opt.expandtab = true

vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
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
	group = api.nvim_create_augroup("tab_eq_2", { clear = true }),
	command = "setlocal shiftwidth=2 softtabstop=2 tabstop=2 expandtab",
})

opt.number = true
api.nvim_create_augroup("rnu_toggle", { clear = true })
api.nvim_create_autocmd({ "BufEnter", "WinEnter", "FocusGained", "InsertLeave" }, {
	pattern = "*",
	group = "rnu_toggle",
	callback = function()
		if opt.number and api.nvim_get_mode().mode ~= "i" then
			opt.relativenumber = true
		end
	end,
})
api.nvim_create_autocmd({ "BufLeave", "WinLeave", "FocusLost", "InsertEnter" }, {
	pattern = "*",
	group = "rnu_toggle",
	callback = function()
		if opt.number then
			opt.relativenumber = false
		end
	end,
})

api.nvim_create_user_command("ReloadConfig", [[lua require("utils.common").reloadConfig()]], {})

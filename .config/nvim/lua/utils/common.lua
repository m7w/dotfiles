local M = {}

local root_modules = {
	"autocommands",
	"keymaps",
	"plugins",
	"settings",
	"utils.common",
}

local cache = (_G.__luacache or {}).cache

function M.reloadConfig()
	for _, module in ipairs(root_modules) do
		package.loaded[module] = nil
		if cache then
			cache[module] = nil
		end
	end

	for module, _ in pairs(package.loaded) do
		if module:match("^config") then
			package.loaded[module] = nil
			if cache then
				cache[module] = nil
			end
		end
	end

	local reloaded, _ = pcall(dofile, vim.env.MYVIMRC)
	if reloaded then
		vim.notify("Config reloaded!!!")
	end
end

local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })

function M.lazygit_toggle()
	lazygit:toggle()
end

return M

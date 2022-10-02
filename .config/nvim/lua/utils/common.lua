local M = {}

local root_modules = {
	"autocommands",
	"keymaps",
	"plugins",
	"settings",
	"utils.common",
}

function M.reloadConfig()
	for _, module in ipairs(root_modules) do
		package.loaded[module] = nil
	end

	for module, _ in pairs(package.loaded) do
		if module:match("^config") then
			package.loaded[module] = nil
		end
	end

	dofile(vim.env.MYVIMRC)
	vim.notify("Config reloaded!!!")
end

return M

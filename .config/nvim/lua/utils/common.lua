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
	local file = io.open("modules.txt", "w")
	for module, _ in pairs(package.loaded) do
		package.loaded[module] = nil
	end
	io.close(file)
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

return M

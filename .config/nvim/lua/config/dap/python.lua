local M = {}

local function get_python_executeable()
	if os.getenv("VIRTUAL_ENV") ~= nil then
		return os.getenv("VIRTUAL_ENV") .. "/bin/python"
	else
		return "/usr/bin/python3"
	end
end

function M.setup()
	local dap = require("dap")

	---@param config table
	dap.adapters.python = function(cb, config)
		if config.request == "attach" then
			local port = (config.connect or config).port
			local host = (config.connect or config).host or "127.0.0.1"
			cb({
				type = "server",
				port = assert(port, "`connect.port` is required for a python `attach` configuration"),
				host = host,
				options = {
					source_filetype = "python",
				},
			})
		else
			cb({
				type = "executable",
				command = vim.fn.exepath("debugpy"),
				args = { "-m", "debugpy.adapter" },
				options = {
					source_filetype = "python",
				},
			})
		end
	end

	dap.configurations.python = {
		{
			type = "python",
			name = "Launch file",
			request = "launch",

			program = "${file}",
			pythonPath = get_python_executeable(),
		},
		{
			type = "python",
			name = "Launch file with args",
			request = "launch",

			program = "${file}",
			pythonPath = get_python_executeable(),
			args = function()
				local input = vim.fn.input({ prompt = "Command line args: " })
				local args = {}
				for arg in string.gmatch(input, "[^%s]+") do
					table.insert(args, arg)
				end
				return args
			end,
		},
	}
end

return M

local M = {}

function M.setup()
	local dap = require("dap")

	dap.adapters.lldb = {
		type = "executable",
		command = "/usr/bin/lldb-vscode",
		name = "lldb",
	}

	dap.configurations.cpp = {
		{
			name = "Launch",
			type = "lldb",
			request = "launch",
			program = function()
				return vim.fn.input({
					prompt = "Path to executable: ",
					default = vim.fn.getcwd() .. "/",
					completion = "file",
				})
			end,
			cwd = "${workspaceFolder}",
			stopOnEntry = false,
			args = {},
			env = function()
				local variables = {}
				for k, v in pairs(vim.fn.environ()) do
					table.insert(variables, string.format("%s=%s", k, v))
				end
				return variables
			end,
		},
		{
			name = "Attach to Name",
			type = "lldb",
			request = "attach",
			program = function()
				return vim.fn.input({
					prompt = "Process name: ",
					default = vim.fn.getcwd() .. "/",
					completion = "file",
				})
			end,
		},
		{
			name = "Load coredump",
			type = "lldb",
			request = "attach",
			coreFile = function()
				return vim.fn.input({
					prompt = "Core file: ",
					default = vim.fn.getcwd() .. "/",
					completion = "file",
				})
			end,
			program = function()
				return vim.fn.input({
					prompt = "Path to the associated executable: ",
					default = vim.fn.getcwd() .. "/",
					completion = "file",
				})
			end,
		},
	}

	dap.configurations.c = dap.configurations.cpp
end

return M

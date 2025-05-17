local M = {}

function M.setup()
	local dap = require("dap")

	dap.configurations.java = {
		{
			type = "java",
			request = "launch",
			name = "Debug with args",
			program = "${file}",
			args = "${command:SpecifyProgramArgs}",
		},
	}
end

return M

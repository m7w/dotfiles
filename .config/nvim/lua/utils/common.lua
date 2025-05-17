local M = {}

local Terminal = require("toggleterm.terminal").Terminal
local gitui = Terminal:new({ cmd = "gitui", hidden = true })

function M.gitui_toggle()
	gitui:toggle()
end

return M

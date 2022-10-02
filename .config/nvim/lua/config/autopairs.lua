local M = {}

function M.setup()
	require("nvim-autopairs").setup({
		check_ts = true,
	})
end

return M

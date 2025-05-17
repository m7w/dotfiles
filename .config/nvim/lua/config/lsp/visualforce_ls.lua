local M = {}

function M.setup(opts)
	local default_opts = {
		cmd = {
			vim.fn.exepath("visualforce-language-server"),
			"--stdio",
		},
	}

	local merged_config = vim.tbl_deep_extend("force", default_opts, opts or {})
	require("lspconfig").visualforce_ls.setup(merged_config)
end

return M

local M = {}

function M.setup(opts)
	local default_opts = {
		settings = {
			Lua = {
				completion = {
					keywordSnippet = "Replace",
					callSnippet = "Replace",
				},
				workspace = {
					checkThirdParty = false,
				},
				telemetry = {
					enable = false,
				},
				hint = {
					enable = true,
				},
			},
		},
	}

	local merged_opts = vim.tbl_deep_extend("force", default_opts, opts or {})
	require("lspconfig").lua_ls.setup(merged_opts)
end

return M

local M = {}

function M.setup(opts)
	-- local default_opts = {
	-- 	filetypes = { "visualforce" },
	-- }
	--
	-- local merged_config = vim.tbl_deep_extend("force", default_opts, opts or {})
	require("lspconfig").eslint.setup({
		on_attach = opts.on_attach,
		capabilities = opts.capabilities,
		settings = {
			validate = "on",
		},
		filetypes = {
			"javascript",
			"typescript",
			"javascriptreact",
			"typescriptreact",
			"visualforce",
			"vue",
		},
	})
end

return M

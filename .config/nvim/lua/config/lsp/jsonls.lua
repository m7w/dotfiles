local M = {}

function M.setup(opts)
	require("lspconfig").jsonls.setup({
		capabilities = opts.capabilities,
		on_attach = opts.on_attach,
		settings = {
			json = { schemas = require("schemastore").json.schemas(), validate = { enable = true } },
		},
	})
end

return M

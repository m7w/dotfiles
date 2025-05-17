local M = {}

function M.setup(opts)
	require("lspconfig").yamlls.setup({
		capabilities = opts.capabilities,
		-- on_attach = function(client, bufnr)
		--     if vim.bo[bufnr].filetype == "helm" then
		--         client.server_capabilities = {}
		--     end
		-- end,
		settings = {
			yaml = {
				keyOrdering = false,
				schemaStore = {
					-- You must disable built-in schemaStore support if you want to use
					-- this plugin and its advanced options like `ignore`.
					enable = false,
					-- Avoid TypeError: Cannot read properties of undefined (reading 'length')
					url = {
						"https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json",
						"https://json.schemastore.org/pubspec.json",
					},
				},
				schemas = require("schemastore").yaml.schemas(),
			},
		},
	})
end

return M

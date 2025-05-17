local M = {}

function M.setup(opts)
	require("lspconfig").groovyls.setup({
		root_dir = require("lspconfig").util.root_pattern("pom.xml", "build.gradle", "settings.gradle"),
		on_attach = opts.on_attach,
		cmd = {
			vim.fn.exepath("groovy-language-server"),
		},
	})
end

return M

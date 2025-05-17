local M = {}

function M.setup(opts)
	require("lspconfig").tailwindcss.setup({
		root_dir = require("lspconfig").util.root_pattern(
			"tailwind.config.cjs",
			"tailwind.config.js",
			"postcss.config.js"
		),
	})
end

return M

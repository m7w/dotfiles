local M = {}

local nls = require("null-ls")
local formatting = nls.builtins.formatting
local diagnostics = nls.builtins.diagnostics
local code_actions = nls.builtins.code_actions

local sources = {
	diagnostics.chktex,
	-- Lua
	formatting.stylua,
	-- Shell
	formatting.shfmt,
	-- JS/TS/Markdown
	formatting.prettierd.with({
		env = {
			PRETTIERD_DEFAULT_CONFIG = vim.fn.expand("$HOME/.config/nvim/prettierrc.json"),
		},
		timeout = 10000,
	}),
	-- JSON
	formatting.fixjson,
	-- Python
	formatting.black,
	formatting.isort,

	code_actions.gitsigns,
}

function M.setup(opts)
	nls.setup({
		debounce = 150,
		save_after_format = false,
		sources = sources,
		on_attach = opts.on_attach,
		root_dir = opts.root_dir,
	})
end

return M

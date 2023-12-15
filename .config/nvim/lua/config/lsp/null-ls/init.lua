local M = {}

local nls = require("null-ls")
local formatting = nls.builtins.formatting
local diagnostics = nls.builtins.diagnostics
local code_actions = nls.builtins.code_actions

local sources = {
	diagnostics.chktex,
	-- XML, HTML
	diagnostics.tidy.with({
		extra_args = { "--mute 'PROPRIETARY_ATTRIBUTE'" },
	}),
	-- js, ts, React, Vue
	diagnostics.eslint_d,
	-- Protobuf
	diagnostics.buf,

	-- XML
	formatting.tidy.with({
		filetypes = { "xml" },
		extra_args = { "-xml" },
	}),
    -- LaTeX
    formatting.latexindent.with({
        extra_args = { "-m", "-l", "settings.yaml"}
    }),
	-- Lua
	formatting.stylua,
	-- Shell
	formatting.shfmt,
	-- Protobuf
	formatting.buf,
	-- JS/TS/Markdown
	formatting.prettierd.with({
		env = {
			PRETTIERD_DEFAULT_CONFIG = vim.fn.expand("$HOME/.config/nvim/prettierrc.json"),
		},
		timeout = 10000,
	}),
	-- Java
	formatting.google_java_format.with({
		extra_args = { "--aosp", "--skip-sorting-imports" },
	}),
	-- Python
	formatting.black,
	formatting.isort,

	code_actions.gitsigns,
	-- js, ts, React, Vue
	code_actions.eslint_d,
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

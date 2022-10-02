local M = {}

function M.setup(opts)
	require("lspconfig").texlab.setup({
		filetypes = { "tex", "plaintex", "bib", "sty" },
		settings = {
			texlab = {
				-- rootDirectory = opts.root_dir,
				auxDirectory = "build",
				build = {
					executable = "latexmk",
					args = {
						"-xelatex",
						"-file-line-error",
						"-synctex=1",
						"-interaction=nonstopmode",
						"%f",
					},
					onSave = true,
					forwardSearchAfter = true,
				},
				chktex = {
					onOpenAndSave = true,
				},
				diagnosticsDelay = 300,
				formatterLineLength = 120,
				forwardSearch = {
					args = {
						"--unique",
						"file:%p#src:%l%f",
					},
					executable = "okular",
				},
			},
		},
	})

	-- For some reason cmp doesn't detect tex filetype as latex
	-- So using this autocmd for now.
	local texSnippets = vim.api.nvim_create_augroup("TexSnippets", { clear = true })
	vim.api.nvim_create_autocmd("FileType", {
		pattern = "tex",
		group = texSnippets,
		command = [[lua require("cmp").setup.buffer({ sources = {
            { name = 'luasnip' },
            { name = 'nvim_lsp_signature_help' },
            { name = 'treesitter' },
            { name = 'buffer' },
            { name = 'path' },
        } })]],
	})
end

return M

local M = {}

function M.setup(opts)
	local root_dir = vim.fn.getcwd()

	require("lspconfig").texlab.setup({
		filetypes = { "tex", "plaintex", "bib", "sty" },
		settings = {
			texlab = {
				rootDirectory = root_dir,
				auxDirectory = "build",
				build = {
					executable = "latexmk",
					args = {
						"-xelatex",
						"-outdir=./build",
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
	vim.api.nvim_create_augroup("tex_snippets", { clear = true })
	vim.api.nvim_create_autocmd("FileType", {
		pattern = "*.tex",
		group = "tex_snippets",
		callback = function()
			require("cmp").setup.buffer({
				sources = {
					{ name = "luasnip" },
					{ name = "nvim_lsp_signature_help" },
					{ name = "treesitter" },
					{ name = "buffer" },
					{ name = "path" },
				},
			})
		end,
	})
end

return M

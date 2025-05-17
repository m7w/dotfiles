return {
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>cf",
				function()
					require("conform").format({ async = true, lsp_format = "fallback", stop_after_first = true })
				end,
				mode = "",
				desc = "Format buffer",
			},
		},
		config = function()
			local prettier = { "prettierd", "prettier" }
			require("conform").setup({
				formatters_by_ft = {
					lua = { "stylua" },
					java = { "google_java_format" },
					python = { "ruff_isort" },
					javascript = prettier,
					typescript = prettier,
					javascriptreact = prettier,
					typescriptreact = prettier,
					html = prettier,
					css = prettier,
					apex = prettier,
					visualforce = prettier,
					sql = { "sqlfluff" },
					psql = { "sqlfluff" },
					soql = { "sqlfluff" },
					json = { "yq" },
					yaml = { "yq" },
				},
				formatters = {
					google_java_format = {
						command = "google-java-format",
						args = { "--aosp", "-" },
					},
					ruff_isort = {
						command = "ruff",
						args = { "check", "--fix", "--force-exclude", "--select", "I", "--stdin-filename", "$FILENAME" },
						stdin = true,
					},
					sqlfluff = {
						require_cwd = false,
						args = function()
							local ft = vim.bo.filetype
							if ft == "soql" then
								return { "fix", "--dialect", "soql", "-" }
							else
								return { "fix", "--dialect", "ansi", "--FIX-EVEN-UNPARSABLE", "-" }
							end
						end,
					},
					yq = {
						append_args = function()
							local ft = vim.bo.filetype
							if ft == "json" then
								return { "-o=json" }
							else
								return {}
							end
						end,
					},
				},
				format_on_save = function(bufnr)
					if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
						return
					else
						return {
							timeout_ms = 5000,
							lsp_fallback = true,
						}
					end
				end,
				log_level = vim.log.levels.DEBUG,
			})

			vim.api.nvim_create_user_command("FormatToggle", function(args)
				if args.bang then
					vim.b[0].disable_autoformat = not vim.b[0].disable_autoformat
					local action = vim.b[0].disable_autoformat and "Disabled" or "Enabled"
					vim.notify(
						action .. " format-on-save for this buffer",
						vim.log.levels.INFO,
						{ title = "Formatting" }
					)
				else
					vim.g.disable_autoformat = not vim.g.disable_autoformat
					local action = vim.g.disable_autoformat and "Disabled" or "Enabled"
					vim.notify(action .. " format-on-save", vim.log.levels.INFO, { title = "Formatting" })
				end
			end, {
				desc = "Toggle format-on-save",
				bang = true,
			})
		end,
	},
}

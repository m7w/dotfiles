return {
	"mfussenegger/nvim-lint",
	config = function()
		require("lint").linters_by_ft = {
			css = { "stylelint" },
			-- html = { "eslint_d" },
			-- javascript = { "eslint_d" },
			-- typescript = { "eslint_d" },
			-- vue = { "eslint_d" },
			-- visualforce = { "eslint_d" },
			plaintex = { "chktex" },
			proto = { "buf_lint" },
			sql = { "sqlfluff" },
			psql = { "sqlfluff" },
			json = { "yq" },
			yaml = { "yq" },
		}

		vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost", "InsertLeave" }, {
			group = vim.api.nvim_create_augroup("try_lint", { clear = true }),
			callback = function()
				require("lint").try_lint()
			end,
		})

		vim.api.nvim_create_user_command("DiagnosticToggle", function()
			local enabled = false
			if vim.diagnostic.is_enabled() then
				enabled = true
			end
			enabled = not enabled

			local action = ""
			if enabled then
				vim.diagnostic.enable()
				action = "Enabled"
			else
				vim.diagnostic.enable(false)
				action = "Disabled"
			end
			vim.notify(action .. " diagnostic", vim.log.levels.INFO, { title = "Diagnostic" })
		end, {
			desc = "Toggle diagnostic",
		})
	end,
}

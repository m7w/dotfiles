vim.g.dbext_default_ORA_bin = "sql"

return {
	{
		"kristijanhusak/vim-dadbod-ui",
		dependencies = {
			{ "tpope/vim-dadbod", cmd = "DB", lazy = true },
			{ "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
		},
		ft = { "sql", "mysql", "plsql" },
		event = "VeryLazy",
		init = function()
			vim.g.db_ui_use_nerd_fonts = 1
			vim.g.db_ui_execute_on_save = 0
		end,
	},
}

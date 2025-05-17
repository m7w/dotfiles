return {
	"ThePrimeagen/refactoring.nvim",
	keys = {
		{
			"<leader>rr",
			mode = { "n", "x" },
			function()
				require("telescope").extensions.refactoring.refactors()
			end,
			desc = "Refactor",
		},
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	config = true,
}

return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
		},
		"nvim-telescope/telescope-file-browser.nvim",
		"nvim-telescope/telescope-ui-select.nvim",
		"debugloop/telescope-undo.nvim",
	},

	-- keys = {
	-- 	{
	-- 		"<leader>:",
	-- 		"<cmd>Telescope command_history<CR>",
	-- 		desc = "Command history",
	-- 	},
	-- 	{
	-- 		"<leader>fb",
	-- 		"<cmd>Telescope buffers<CR>",
	-- 		desc = "Find Buffers",
	-- 	},
	-- 	{
	-- 		"<leader>fd",
	-- 		"<cmd>Telescope diagnostics<CR>",
	-- 		desc = "Open Diagnostic",
	-- 	},
	-- 	{
	-- 		"<leader>fe",
	-- 		"<cmd>Telescope file_browser path=%:p:help |select_buffer=true<CR>|",
	-- 		desc = "Explore Files",
	-- 	},
	-- 	{ "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find Files" },
	-- 	{ "<leader>fg", "<cmd>Telescope live_grep<CR>", desc = "Live Grep" },
	-- 	{ "<leader>fh", "<cmd>Telescope help_tags<CR>", desc = "Help Tags" },
	-- 	{
	-- 		"<leader>fr",
	-- 		"<cmd>Telescope oldfiles<CR>",
	-- 		desc = "Open Recent File",
	-- 	},
	-- 	{
	-- 		"<leader>fs",
	-- 		"<cmd>Telescope lsp_document_symbols<CR>",
	-- 		desc = "LSP Symbols",
	-- 	},
	-- 	{
	-- 		"<leader>ft",
	-- 		"<cmd>Telescope treesitter<CR>",
	-- 		desc = "Treesitter Tags",
	-- 	},
	-- },

	opts = {
		defaults = {
			layout_config = {
				preview_cutoff = 0,
				horizontal = {
					width = 0.9,
					preview_width = 0.5,
				},
			},
			selection_strategy = "closest",
			sorting_strategy = "ascending",
			mappings = {
				i = {
					-- ["<C-j>"] = "move_selection_next",
					-- ["<C-k>"] = "move_selection_previous",
					["<Esc>"] = "close",
				},
			},
		},
		pickers = {
			live_grep = {
				glob_pattern = "!node_modules",
			},
		},
		extensions = {
			file_browser = {
				respect_gitignore = false,
			},
			["ui-select"] = {
				require("telescope.themes").get_dropdown({
					-- even more opts
				}),
			},
			undo = {
				side_by_side = true,
				layout_strategy = "vertical",
				layout_config = {
					preview_height = 0.6,
				},
			},
		},
	},
	config = function(_, opts)
		local telescope = require("telescope")
		telescope.setup(opts)

		telescope.load_extension("fzf")
		telescope.load_extension("file_browser")
		telescope.load_extension("ui-select")
		telescope.load_extension("refactoring")
		telescope.load_extension("undo")
	end,
}

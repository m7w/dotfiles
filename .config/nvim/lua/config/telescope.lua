local M = {}

function M.setup()
	require("telescope").setup({
		defaults = {
			layout_config = {
				horizontal = {
					width = 0.9,
					preview_width = 0.5,
				},
			},
			selection_strategy = "reset",
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
			-- picker_name = {
			--   picker_config_key = value,
			--   ...
			-- }
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
		},
	})

	require("telescope").load_extension("ui-select")
	require("telescope").load_extension("termfinder")
	require("telescope").load_extension("file_browser")
	require("telescope").load_extension("dap")
end

return M

local M = {}

function M.setup()
	require("telescope").setup({
		defaults = {
			-- layout_config = {
			-- 	width = 0.9,
			-- 	preview_width = 0.5,
			-- },
			-- prompt_prefix = "  ",
			-- selection_caret = "➤ ",
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
			-- extension_name = {
			--   extension_config_key = value,
			-- }
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
end

return M

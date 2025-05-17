return {
	"akinsho/bufferline.nvim",
	version = "*",
	event = "VeryLazy",
	after = "catppuccin",

	opts = {
		options = {
			mode = "tabs",
			---@param opts table
			numbers = function(opts)
				return string.format("%s·%s", opts.ordinal, opts.lower(opts.id))
			end,
			diagnostics = "nvim_lsp",
			diagnostics_update_in_insert = false,
			---@diagnostic disable-next-line: unused-local
			diagnostics_indicator = function(count, level, diagnostics_dict, context)
				local s = " "
				for e, n in pairs(diagnostics_dict) do
					local sym = e == "error" and "⨂" or (e == "warning" and "⚠" or "ℹ")
					s = s .. n .. sym
				end
				return s
			end,
			offsets = {
				{
					filetype = "NvimTree",
					text = "File Explorer",
					text_align = "left",
					separator = true,
				},
			},
			color_icons = false,
			show_tab_indicators = false,
			persist_buffer_sort = false,
			sort_by = "tabs",
		},
	},
	config = function(_, opts)
		local highlights = require("catppuccin.groups.integrations.bufferline").get()
		table.insert(opts.options, highlights)
		require("bufferline").setup(opts)
	end,
}

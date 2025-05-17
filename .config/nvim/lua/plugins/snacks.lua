return {
	"folke/snacks.nvim",
	lazy = false,
	priority = 1000,
	---@type snacks.Config
	opts = {
		animate = { enabled = true },
		bigfile = { enabled = true },
		bufdelete = { enabled = true },
		dashboard = {
			sections = {
				{ section = "header" },
				{ icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
				{
					pane = 2,
					icon = " ",
					title = "Git Status",
					section = "terminal",
					enabled = function()
						return Snacks.git.get_root() ~= nil
					end,
					cmd = "git status --short --branch --renames; \
                        echo '\n'; \
                        git --no-pager diff --stat -B -M -C",
					height = 20,
					padding = 1,
					ttl = 5 * 60,
					indent = 3,
				},
				{ icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
				{ icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
				{ section = "startup" },
			},
		},
		debug = { enabled = true },
		dim = {},
		explorer = {},
		git = { enabled = true },
		gitbrowse = { enabled = true },
		indent = {
			indent = {
				char = "▏",
			},
			scope = {
				char = "▎",
			},
		},
		input = { enabled = true },
		image = {},
		notifier = { enabled = true },
		notify = { enabled = true },
		quickfile = { enabled = true },
		rename = { enabled = true },
		picker = {
			layout = {
				cycle = true,
				preset = function()
					return vim.o.columns >= 120 and "telescope" or "vertical"
				end,
			},
			layouts = {
				telescope = {
					reverse = false,
					layout = {
						box = "horizontal",
						backdrop = false,
						width = 0.9,
						height = 0.85,
						border = "none",
						{
							box = "vertical",
							{ win = "list", title = " Results ", title_pos = "center", border = "rounded" },
							{
								win = "input",
								height = 1,
								border = "rounded",
								title = "{title} {live} {flags}",
								title_pos = "center",
							},
						},
						{
							win = "preview",
							title = "{preview:Preview}",
							width = 0.5,
							border = "rounded",
							title_pos = "center",
						},
					},
				},
			},
			sources = {
				command_history = {
					layout = { preset = "select" },
				},
			},
		},
		scratch = { enabled = true },
		scope = { enabled = true },
		scroll = { enabled = false },
		statuscolumn = {
			folds = {
				open = true,
			},
		},
		terminal = { enabled = true },
		util = { enabled = true },
		words = {},
		zen = {},
		styles = {
			zen = {
				enter = true,
				fixbuf = false,
				minimal = false,
				width = 120,
				height = 0,
				backdrop = { transparent = false },
				keys = { q = false },
				zindex = 40,
				wo = {
					winhighlight = "NormalFloat:Normal",
				},
			},
		},
	},
	keys = {
		{
			[[<C-\>]],
			function()
				Snacks.terminal("zsh", { win = { position = "bottom" } })
			end,
			mode = "n",
			desc = "Toggle Terminal",
		},
		{
			[[<C-\>]],
			"<cmd>close<CR>",
			mode = "t",
			desc = "Hide Terminal",
		},
		{
			"<leader>g",
			function()
				Snacks.terminal("gitui")
			end,
			desc = "Gitui",
		},
		{
			"<leader>s",
			function()
				Snacks.scratch()
			end,
			desc = "Toggle Scratch Buffer",
		},
		{
			"<leader>S",
			function()
				Snacks.scratch.select()
			end,
			desc = "Select Scratch Buffer",
		},
		{
			"<leader>m",
			function()
				Snacks.picker.smart()
			end,
			desc = "Smart Find Files",
		},
		{
			"<leader>:",
			function()
				Snacks.picker.command_history()
			end,
			desc = "Command History",
		},
		{
			"<leader>/",
			function()
				Snacks.picker.grep({ exclude = { "node_modules", "site-packages" } })
			end,
			desc = "Grep",
		},
		{
			"<leader>u",
			function()
				Snacks.picker.undo()
			end,
			desc = "Undo History",
		},
		{
			"<leader>fb",
			function()
				Snacks.picker.buffers()
			end,
			desc = "Buffers",
		},
		{
			"<leader>fc",
			function()
				Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
			end,
			desc = "Find Config File",
		},
		{
			"<leader>ff",
			function()
				Snacks.picker.files()
			end,
			desc = "Find Files",
		},
		{
			"<leader>fG",
			function()
				Snacks.picker.git_files()
			end,
			desc = "Find Git Files",
		},
		{
			"<leader>fg",
			function()
				Snacks.picker.git_diff()
			end,
			desc = "Find Git Diff",
		},
		{
			"<leader>fr",
			function()
				Snacks.picker.recent()
			end,
			desc = "Recent",
		},
		{
			"<leader>fm",
			function()
				Snacks.picker.marks()
			end,
			desc = "Marks",
		},
		{
			"<leader>fs",
			function()
				Snacks.picker.lsp_symbols()
			end,
			desc = "LSP Symbols",
		},
		{
			"<leader>fd",
			function()
				Snacks.picker.diagnostics()
			end,
			desc = "Diagnostics",
		},
		{
			"<leader>fe",
			function()
				Snacks.picker.explorer()
			end,
			desc = "File Explorer",
		},
		{
			"<leader>fq",
			function()
				Snacks.picker.qflist()
			end,
			desc = "Quickfix",
		},
	},
	init = function()
		vim.api.nvim_create_autocmd("ColorScheme", {
			callback = function()
				if vim.g.colors_name:find("catppuccin") then
					local C = require("catppuccin.palettes").get_palette()
					vim.api.nvim_set_hl(0, "SnacksIndent", { fg = C.surface0 })
					vim.api.nvim_set_hl(0, "SnacksIndentScope", { fg = C.text })
				end
			end,
		})

		vim.api.nvim_create_autocmd("User", {
			pattern = "VeryLazy",
			callback = function()
				_G.dd = function(...)
					Snacks.debug.inspect(...)
				end
				_G.bt = function()
					Snacks.debug.backtrace()
				end

				Snacks.toggle.dim():map("<leader>tD")
				Snacks.toggle.inlay_hints():map("<leader>th")
				Snacks.toggle.diagnostics():map("<leader>td")
				Snacks.toggle
					.new({
						id = "autoformat",
						name = "Autoformat on save",
						get = function()
							return not vim.b[0].disable_autoformat
						end,
						set = function(state)
							if state then
								vim.b[0].disable_autoformat = false
							else
								vim.b[0].disable_autoformat = true
							end
						end,
					})
					:map("<leader>tf")
			end,
		})

		local prev = { new_name = "", old_name = "" } -- Prevents duplicate events
		vim.api.nvim_create_autocmd("User", {
			pattern = "NvimTreeSetup",
			callback = function()
				local events = require("nvim-tree.api").events
				events.subscribe(events.Event.NodeRenamed, function(data)
					if prev.new_name ~= data.new_name or prev.old_name ~= data.old_name then
						data = data
						Snacks.rename.on_rename_file(data.old_name, data.new_name)
					end
				end)
			end,
		})
	end,
}

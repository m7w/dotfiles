return {

	"folke/which-key.nvim",
	enabled = true,
	dependencies = { "Wansmer/langmapper.nvim" },
	config = function()
		-- vim.o.timeout = true
		-- vim.o.timeoutlen = 300
		--
		-- local lmu = require("langmapper.utils")
		-- local view = require("which-key.view")
		-- local execute = view.execute
		--
		-- -- wrap `execute()` and translate sequence back
		-- ---@diagnostic disable-next-line: duplicate-set-field
		-- view.execute = function(prefix_i, mode, buf)
		-- 	-- Translate back to English characters
		-- 	prefix_i = lmu.translate_keycode(prefix_i, "default", "ru")
		-- 	execute(prefix_i, mode, buf)
		-- end

		-- If you want to see translated operators, text objects and motions in
		-- which-key prompt
		-- local presets = require('which-key.plugins.presets')
		-- presets.operators = lmu.trans_dict(presets.operators)
		-- presets.objects = lmu.trans_dict(presets.objects)
		-- presets.motions = lmu.trans_dict(presets.motions)
		-- etc
		local wk = require("which-key")

		wk.add({
			{ "<leader>f", group = "Telescope" },
			{
				"<leader>e",
				"<cmd>NvimTreeToggle<CR>",
				desc = "NvimTreeToggle",
			},

			-- { "<leader>g", '<cmd>lua require("utils.common").gitui_toggle()<CR>', desc = "gitui" },

			{ "<leader>h", group = "Gitsigns" },
			{
				"<leader>hd",
				"<cmd>lua require('gitsigns').toggle_deleted()<CR>",
				desc = "Toggle show deleted",
			},
			{ "<leader>hn", "<cmd>Gitsigns next_hunk<CR>", desc = "Next hunk" },
			{
				"<leader>hp",
				"<cmd>Gitsigns prev_hunk<CR>",
				desc = "Previous hunk",
			},
			{ "<leader>hr", "<cmd>Gitsigns reset_hunk<CR>", desc = "Reset hunk" },
			{ "<leader>hs", "<cmd>Gitsigns stage_hunk<CR>", desc = "Stage hunk" },
			{
				"<leader>hv",
				"<cmd>Gitsigns preview_hunk<CR>",
				desc = "Preview hunk",
			},
			{
				"<leader>hb",
				"<cmd>Gitsigns blame_line<CR>",
				desc = "Blame line",
			},

			{ "<leader>l", group = "Latex" },
			{
				"<leader>le",
				"<cmd>TexlabToggleLog<CR>",
				desc = "Texlab Build Log",
			},
			{
				"<leader>lk",
				"<cmd>TexlabStopBuild<CR>",
				desc = "Texlab Stop Build",
			},
			{
				"<leader>ll",
				"<cmd>TexlabBuild<CR>",
				desc = "Texlab Build",
			},
			{
				"<leader>lv",
				"<cmd>TexlabForward<CR>",
				desc = "Document Preview",
			},

			{ "<leader>n", group = "Generate annotations" },
			{
				"<leader>nc",
				"<cmd>lua require('neogen').generate({ type = 'class' })<CR>",
				desc = "Annotation for class",
			},
			{
				"<leader>nf",
				"<cmd>lua require('neogen').generate({ type = 'func' })<CR>",
				desc = "Annotation for function",
			},
			{
				"<leader>nt",
				"<cmd>lua require('neogen').generate({ type = 'type' })<CR>",
				desc = "Annotation for type",
			},
			-- { "<leader>u", "<cmd>Telescope undo<CR>", desc = "Undo" },

			{ "<leader>z", group = "True-Zen" },
			{ "<leader>za", "<cmd>TZAtaraxis<CR>", desc = "Ataraxis" },
			{ "<leader>zf", "<cmd>TZFocus<CR>", desc = "Focus" },
			{ "<leader>zm", "<cmd>TZMinimalist<CR>", desc = "Minimalist" },

			{ "<leader>q", group = "Persistence" },
			{
				"<leader>qs",
				"<cmd>lua require('persistence').load()<CR>",
				desc = "Load the session for the current dir",
			},
			{ "<leader>qS", "<cmd>lua require('persistence').select()<CR>", desc = "Select a session to load" },
			{
				"<leader>ql",
				"<cmd>lua require('persistence').load({ last = true })<CR>",
				desc = "Load the last session",
			},
			{ "<leader>qd", "<cmd>lua require('persistence').stop()<CR>", desc = "Stop Persistence" },
		})
	end,
}

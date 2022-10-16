local M = {}

function M.setup()
	local wk = require("which-key")

	wk.register({
		["<leader>"] = {
			f = {
				name = "Telescope",
				e = { "<cmd>Telescope file_browser<CR>", "Find Files" },
				f = { "<cmd>Telescope find_files<CR>", "Find Files" },
				r = { "<cmd>Telescope oldfiles<CR>", "Open Recent File" },
				b = { "<cmd>Telescope buffers<CR>", "Find Buffers" },
				g = { "<cmd>Telescope live_grep<CR>", "Live Grep" },
				d = { "<cmd>Telescope diagnostics<CR>", "Open Diagnostic" },
				t = { "<cmd>Telescope treesitter<CR>", "Treesitter Tags" },
				s = { "<cmd>Telescope lsp_document_symbols<CR>", "LSP Symbols" },
			},
			z = {
				name = "True-Zen",
				a = { "<cmd>TZAtaraxis<CR>", "Ataraxis" },
				f = { "<cmd>TZFocus<CR>", "Focus" },
				m = { "<cmd>TZMinimalist<CR>", "Minimalist" },
			},
			h = {
				name = "Gitsigns",
				n = { "<cmd>Gitsigns next_hunk<CR>", "Next hunk" },
				p = { "<cmd>Gitsigns prev_hunk<CR>", "Previous hunk" },
				v = { "<cmd>Gitsigns preview_hunk<CR>", "Preview hunk" },
				s = { "<cmd>Gitsigns stage_hunk<CR>", "Stage hunk" },
			},
		},
	})
end

return M

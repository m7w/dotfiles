local M = {}

function M.setup()
	local wk = require("which-key")

	wk.register({
		["<leader>"] = {
			f = {
				name = "Telescope",
				e = { "<cmd>Telescope file_browser path=%:p:h select_buffer=true<CR>", "Explore Files" },
				f = { "<cmd>Telescope find_files<CR>", "Find Files" },
				r = { "<cmd>Telescope oldfiles<CR>", "Open Recent File" },
				b = { "<cmd>Telescope buffers<CR>", "Find Buffers" },
				g = { "<cmd>Telescope live_grep<CR>", "Live Grep" },
				d = { "<cmd>Telescope diagnostics<CR>", "Open Diagnostic" },
				t = { "<cmd>Telescope treesitter<CR>", "Treesitter Tags" },
				h = { "<cmd>Telescope help_tags<CR>", "Help Tags" },
				s = { "<cmd>Telescope lsp_document_symbols<CR>", "LSP Symbols" },
			},
			z = {
				name = "True-Zen",
				a = { "<cmd>TZAtaraxis<CR>", "Ataraxis" },
				f = { "<cmd>TZFocus<CR>", "Focus" },
				m = { "<cmd>TZMinimalist<CR>", "Minimalist" },
			},
			n = {
				name = "Generate annotations",
				f = { "<cmd>require('neogen').generate({ type = 'func' })", "Annotation fo function" },
				c = { "<cmd>require('neogen').generate({ type = 'class' })", "Annotation fo class" },
				t = { "<cmd>require('neogen').generate({ type = 'type' })", "Annotation fo type" },
			},
			h = {
				name = "Gitsigns",
				n = { "<cmd>Gitsigns next_hunk<CR>", "Next hunk" },
				p = { "<cmd>Gitsigns prev_hunk<CR>", "Previous hunk" },
				v = { "<cmd>Gitsigns preview_hunk<CR>", "Preview hunk" },
				r = { "<cmd>Gitsigns reset_hunk<CR>", "Reset hunk" },
				s = { "<cmd>Gitsigns stage_hunk<CR>", "Stage hunk" },
			},
			l = {
				name = "Latex",
				l = { "<cmd>TexlabBuild<CR>", "Texlab Build" },
				k = { "<cmd>TexlabStopBuild<CR>", "Texlab Stop Build" },
				v = { "<cmd>TexlabForward<CR>", "Document Preview" },
				e = { "<cmd>TexlabToggleLog<CR>", "Texlab Build Log" },
			},
			g = { [[<cmd>lua require("utils.common").lazygit_toggle()<CR>]], "lazygit" },
		},
		["<leader>:"] = { [[<cmd>Telescope command_history<CR>]], "Command history" },
	})
end

return M

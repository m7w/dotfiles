return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = { "BufReadPost", "BufNewFile" },
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
	},
	opts = {
		ensure_installed = "all",
		-- Install languages synchronously (only applied to `ensure_installed`)
		sync_install = false,
		highlight = {
			-- `false` will disable the whole extension
			enable = true,
		},

		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "<c-space>",
				node_incremental = "<c-space>",
				node_decremental = "<BS>",
				scope_incremental = "grc",
			},
		},

		indent = {
			enable = false, -- when true produced bad results
			-- disable = { "python", "java", "rust", "lua", "typescript" },
		},

		-- vim-matchup
		matchup = {
			enable = true,
		},

		--nvim-ts-autotag
		autotag = {
			enable = true,
		},

		-- nvim-treesitter-textobjects
		textobjects = {
			select = {
				enable = true,

				-- Automatically jump forward to textobj, similar to targets.vim
				lookahead = true,

				keymaps = {
					["af"] = "@function.outer",
					["if"] = "@function.inner",
					["ac"] = "@class.outer",
					["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
				},
				selection_modes = {
					["@parameter.outer"] = "v", -- charwise
					["@function.outer"] = "V", -- linewise
					["@class.outer"] = "<c-v>", -- blockwise
				},
			},

			swap = {
				enable = true,
				swap_next = {
					["<leader>cn"] = "@parameter.inner",
				},
				swap_previous = {
					["<leader>cp"] = "@parameter.inner",
				},
			},

			move = {
				enable = true,
				set_jumps = true, -- whether to set jumps in the jumplist
				goto_next_start = {
					["]f"] = "@function.outer",
					["]c"] = "@class.outer",
				},
				goto_next_end = {
					["]F"] = "@function.outer",
					["]C"] = "@class.outer",
				},
				goto_previous_start = {
					["[f"] = "@function.outer",
					["[c"] = "@class.outer",
				},
				goto_previous_end = {
					["[F"] = "@function.outer",
					["[C"] = "@class.outer",
				},
			},

			-- lsp_interop = {
			--   enable = true,
			--   border = "none",
			--   peek_definition_code = {
			--     ["<leader>df"] = "@function.outer",
			--     ["<leader>dF"] = "@class.outer",
			--   },
			-- },
		},
	},
	config = function(_, opts)
		require("nvim-treesitter.configs").setup(opts)
		vim.treesitter.language.register("html", "visualforce")
	end,
}

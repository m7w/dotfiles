local M = {}

function M.setup()
	require("nvim-treesitter.configs").setup({
		ensure_installed = "all",
		-- Install languages synchronously (only applied to `ensure_installed`)
		sync_install = false,
		highlight = {
			-- `false` will disable the whole extension
			enable = true,
		},

		rainbow = {
			enable = false,
			extended_mode = true,
			max_file_lines = nil,
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
					-- You can use the capture groups defined in textobjects.scm
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
					["]m"] = "@function.outer",
					["]]"] = "@class.outer",
				},
				goto_next_end = {
					["]M"] = "@function.outer",
					["]["] = "@class.outer",
				},
				goto_previous_start = {
					["[m"] = "@function.outer",
					["[["] = "@class.outer",
				},
				goto_previous_end = {
					["[M"] = "@function.outer",
					["[]"] = "@class.outer",
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

		-- context_commentstring
		context_commentstring = {
			enable = true,
		},
	})
	-- require("treesitter-context").setup {
	--   enable = true,
	-- }
end

return M

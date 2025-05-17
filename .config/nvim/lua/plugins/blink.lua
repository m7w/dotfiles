return {
	{
		"saghen/blink.compat",
		version = "*",
		lazy = true,
		opts = {},
	},
	{
		"saghen/blink.cmp",
		-- optional: provides snippets for the snippet source
		dependencies = {
			{
				"L3MON4D3/LuaSnip",
				build = "make install_jsregexp",
				config = function()
					require("luasnip.loaders.from_vscode").lazy_load({
						paths = { "~/.local/share/nvim/lazy/friendly-snippets", "~/.config/nvim/vscodesnippets/" },
					})
					require("luasnip.loaders.from_lua").lazy_load({ paths = { "~/.config/nvim/luasnippets/" } })
				end,
				dependencies = { "rafamadriz/friendly-snippets" },
			},
			"amarakon/nvim-cmp-lua-latex-symbols",
		},

		-- use a release tag to download pre-built binaries
		version = "1.*",

		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			keymap = {
				preset = "default",
				-- ["<CR>"] = { "select_and_accept" },
			},

			appearance = {
				nerd_font_variant = "mono",
			},

			completion = {
				accept = {
					auto_brackets = {
						enabled = true,
					},
				},
				menu = {
					draw = {
						treesitter = { "lsp" },
						columns = {
							{ "kind_icon", "label", "label_description", gap = 1 },
							{ "kind" },
						},
					},
					border = "rounded",
					winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:BlinkCmpMenuSelection,Search:None",
				},
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 100,
					window = {
						border = "rounded",
						winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:BlinkCmpDocCursorLine,Search:None",
					},
				},
			},

			sources = {
				default = { "lsp", "path", "snippets", "buffer", "latex_symbols" },

				per_filetype = { sql = { "dadbod" } },
				providers = {
					dadbod = { module = "vim_dadbod_completion.blink" },
					latex_symbols = {
						name = "lua-latex-symbols",
						module = "blink.compat.source",
						score_offset = -3,
						opts = {
							cache = true,
						},
					},
				},
			},

			cmdline = {
				enabled = true,
				completion = {
					menu = {
						auto_show = true,
					},
				},
			},

			signature = { enabled = true },

			fuzzy = { implementation = "prefer_rust_with_warning" },
		},
		opts_extend = { "sources.default" },
	},
}

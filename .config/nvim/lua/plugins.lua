local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({

	{ dir = "~/dev/nvim/plugins/pio" },
	-- Appearance
	-- Colorschemes
	{
		"ellisonleao/gruvbox.nvim",
		lazy = true,
		enabled = true,
	},
	{
		"rebelot/kanagawa.nvim",
		lazy = true,
		opts = {
			statementStyle = { italic = true },
		},
		enabled = true,
	},
	{
		"catppuccin/nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				flavor = "macchiato",
				styles = {
					loops = { "italic" },
				},
			})
			vim.cmd("colorscheme catppuccin")
		end,
		enabled = true,
	},

	-- UI
	{ "nvim-tree/nvim-web-devicons", lazy = true },
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		config = function()
			require("config.lualine").setup()
		end,
	},
	{
		"akinsho/bufferline.nvim",
		event = "VeryLazy",
		version = "*",
		config = function()
			require("config.bufferline").setup()
		end,
	},
	"SmiteshP/nvim-navic",
	{
		"j-hui/fidget.nvim",
		tag = "legacy",
		config = true,
	},
	{ "stevearc/dressing.nvim", event = "VeryLazy" },
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		-- opts = ,
		config = function()
			require("ibl").setup({
				scope = {
					enabled = true,
					show_start = false,
					show_end = false,
				},
			})
		end,
	},
	{
		"kyazdani42/nvim-tree.lua",
		config = function()
			require("config.nvim-tree").setup()
		end,
	},
	{
		"NvChad/nvim-colorizer.lua",
		opts = {
			user_default_options = {
				tailwind = true,
			},
		},
	},
	{
		"Pocco81/true-zen.nvim",
		opts = {
			modes = {
				ataraxis = {
					minimum_writing_area = {
						width = 100,
					},
				},
			},
			integrations = {
				twilight = true,
				lualine = true,
			},
		},
	},
	{
		"folke/twilight.nvim",
		config = true,
	},
	{
		"rcarriga/nvim-notify",
		config = function()
			vim.notify = require("notify")
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		config = true,
	},
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			require("config.toggleterm").setup()
		end,
	},

	-- Useful plugins related to keys
	{
		"ggandor/flit.nvim",
		opts = {
			labeled_modes = "nv",
			multiline = false,
		},
		dependencies = {
			{
				"ggandor/leap.nvim",
				config = function()
					require("leap").add_default_mappings(true)
					vim.keymap.del({ "x", "o" }, "x")
					vim.keymap.del({ "x", "o" }, "X")
				end,
			},
			"tpope/vim-repeat",
		},
	},
	{
		"numToStr/Comment.nvim",
		config = true,
		dependencies = {
			"JoosepAlviste/nvim-ts-context-commentstring",
		},
	},
	{
		"kylechui/nvim-surround",
		config = true,
	},
	{
		"folke/which-key.nvim",
		config = function()
			require("config.which-key").setup()
		end,
	},

	-- Docs
	{
		"danymat/neogen",
		opts = { snippet_engine = "luasnip" },
	},

	"folke/neodev.nvim",

	-- LSP
	{
		"neovim/nvim-lspconfig",
		config = function()
			require("config.lsp").setup()
		end,
		-- opts = {
		-- 	inlay_hints = {
		-- 		enabled = true,
		-- 	},
		-- },
	},
	{
		"williamboman/mason.nvim",
		config = true,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = true,
	},
	"jose-elias-alvarez/null-ls.nvim",
	"mfussenegger/nvim-jdtls",

	-- SQL
	{
		"kristijanhusak/vim-dadbod-ui",
		dependencies = {
			"tpope/vim-dadbod",
			"kristijanhusak/vim-dadbod-completion",
		},
	},

	-- PlatformIO
	{ "normen/vim-pio" },

	-- Debuggers
	{
		"rcarriga/nvim-dap-ui",
		lazy = true,
		config = true,
		dependencies = {
			{
				"mfussenegger/nvim-dap",
				config = function()
					require("config.dap.python").setup()
					require("config.dap.go").setup()
				end,
			},
			{ "theHamsta/nvim-dap-virtual-text", config = true },
			{ "LiadOz/nvim-dap-repl-highlights", config = true },
			"nvim-telescope/telescope-dap.nvim",
		},
	},

	-- Completion
	{
		"hrsh7th/nvim-cmp",
		-- event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			{
				"L3MON4D3/LuaSnip",
				build = "make install_jsregexp",
				config = function()
					require("luasnip.loaders.from_vscode").lazy_load()
					require("luasnip.loaders.from_lua").lazy_load({ paths = "~/.config/nvim/luasnippets/" })
				end,
				dependencies = { "rafamadriz/friendly-snippets" },
			},
			"saadparwaiz1/cmp_luasnip",
		},
		config = function()
			require("config.cmp").setup()
		end,
	},

	-- Autopairs
	{
		"windwp/nvim-autopairs",
		config = function()
			require("config.autopairs").setup()
		end,
	},
	-- Autotag
	"windwp/nvim-ts-autotag",

	-- Telescope
	{
		"nvim-telescope/telescope.nvim",
		config = function()
			require("config.telescope").setup()
		end,
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
			},
			"nvim-telescope/telescope-file-browser.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
			"tknightz/telescope-termfinder.nvim",
		},
	},

	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("config.treesitter").setup()
		end,
		dependencies = {
			"nvim-treesitter/nvim-treesitter-refactor",
			"nvim-treesitter/nvim-treesitter-textobjects",
			"nvim-treesitter/playground",
		},
	},

	{
		"iamcco/markdown-preview.nvim",
		build = "cd app && npm install",
		setup = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	},

	"towolf/vim-helm",
})

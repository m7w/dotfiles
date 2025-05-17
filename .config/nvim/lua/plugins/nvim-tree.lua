vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

local on_attach = function(bufnr)
	local api = require("nvim-tree.api")

	local function opts(desc)
		return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	end

	-- BEGIN_DEFAULT_ON_ATTACH
	api.config.mappings.default_on_attach(bufnr)
	-- END_DEFAULT_ON_ATTACH
	vim.keymap.del("n", "s", { buffer = bufnr })
	vim.keymap.del("n", "S", { buffer = bufnr })

	vim.keymap.set("n", "u", api.tree.change_root_to_parent, opts("Up"))

	local preview = require("nvim-tree-preview")
	vim.keymap.set("n", "P", preview.watch, opts("Preview (Watch)"))
	vim.keymap.set("n", "<Esc>", preview.unwatch, opts("Close Preview/Unwatch"))

	vim.keymap.set("n", "<Tab>", preview.node_under_cursor, opts("Preview"))

	vim.keymap.set("n", "<Tab>", function()
		local ok, node = pcall(api.tree.get_node_under_cursor)
		if ok and node then
			if node.type == "directory" then
				api.node.open.edit()
			else
				preview.node(node, { toggle_focus = true })
			end
		end
	end, opts("Preview"))
end

return {
	{
		"nvim-tree/nvim-tree.lua",
		opts = {
			on_attach = on_attach,
			sort_by = "case_sensitive",
			sync_root_with_cwd = true,
			diagnostics = {
				enable = true,
				show_on_dirs = true,
			},
			renderer = {
				group_empty = true,
			},
			filters = {
				dotfiles = true,
			},
			actions = {
				open_file = {
					quit_on_open = true,
				},
			},
		},
		dependencies = {
			"b0o/nvim-tree-preview.lua",
			opts = {
				keymaps = {
					["<Esc>"] = { action = "close", unwatch = true },
					["<Tab>"] = { action = "toggle_focus" },
					["<CR>"] = { open = "edit" },
					["<C-t>"] = { open = "tab" },
					["<C-v>"] = { open = "vertical" },
					["<C-x>"] = { open = "horizontal" },
				},
				min_width = 10,
				min_height = 5,
				max_width = 85,
				max_height = 25,
				wrap = false,
				border = "rounded",
			},
		},
	},
	{
		"antosha417/nvim-lsp-file-operations",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-tree.lua",
		},
		config = function()
			require("lsp-file-operations").setup()
		end,
	},
}

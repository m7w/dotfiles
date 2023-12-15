local M = {}

local function on_attach(bufnr)
	local api = require("nvim-tree.api")

	local function opts(desc)
		return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	end

	-- BEGIN_DEFAULT_ON_ATTACH
	api.config.mappings.default_on_attach(bufnr)
	-- END_DEFAULT_ON_ATTACH

	vim.keymap.set("n", "u", api.tree.change_root_to_parent, opts("Up"))
end

function M.setup()
	vim.g.loaded = 1
	vim.g.loaded_netrwPlugin = 1
	vim.opt.termguicolors = true

	require("nvim-tree").setup({
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
	})
end

return M

local M = {}

function M.setup()
	vim.g.loaded = 1
	vim.g.loaded_netrwPlugin = 1

	require("nvim-tree").setup({
		sort_by = "case_sensitive",
        sync_root_with_cwd = true,
		view = {
			mappings = {
				list = {
					{ key = "u", action = "dir_up" },
				},
			},
		},
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

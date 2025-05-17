return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	config = function()
		local function get_clients()
			local active_clients = vim.lsp.get_clients({ 0 })

			if next(active_clients) == nil then
				return ""
			end

			local all_client_names = {}
			for id, client in pairs(active_clients) do
				local attached_buffers = vim.lsp.get_buffers_by_client_id(id)
				for _, buf_id in pairs(attached_buffers) do
					local buf_clients = all_client_names[buf_id] or {}
					table.insert(buf_clients, client.name)
					all_client_names[buf_id] = buf_clients
				end
			end

			local buf_number = vim.api.nvim_get_current_buf()
			local buf_client_names = all_client_names[buf_number]

			local formatters = require("conform").list_formatters(buf_number)
			local formatters_names = {}
			for _, formatter in ipairs(formatters) do
				table.insert(formatters_names, formatter.name)
			end
			vim.list_extend(buf_client_names, formatters_names)

			local linters = require("lint").get_running(buf_number)
			vim.list_extend(buf_client_names, linters)

			return "[" .. table.concat(buf_client_names, ", ") .. "]"
		end

		local dmode_enabled = false
		vim.api.nvim_create_autocmd("User", {
			pattern = "DebugModeChanged",
			callback = function(args)
				dmode_enabled = args.data.enabled
			end,
		})

		require("lualine").setup({
			options = {
				theme = "catppuccin",
				disabled_filetypes = { "NvimTree" },
			},
			sections = {
				lualine_a = {
					{
						"mode",
						fmt = function(str)
							return dmode_enabled and "DEBUG" or str
						end,
						color = function(tb)
							return dmode_enabled and "dCursor" or tb
						end,
					},
				},
				lualine_c = {
					{ "filename" },
					-- { "%=" },
					{
						"require'salesforce.org_manager':get_default_alias()",
						icon = "󰢎",
						cond = function()
							local root_dir = require("config.salesforce"):sf_project_dir()
							return root_dir ~= nil
						end,
					},
					{ get_clients, icon = " ", color = { fg = "#c678dd", gui = "bold" } },
				},
				-- lualine_x = { "encoding", "fileformat", "filetype" },
				-- lualine_y = { "progress" },
				-- lualine_z = { "location" },
			},
			-- inactive_sections = {
			-- 	lualine_a = {},
			-- 	lualine_b = {},
			-- 	lualine_c = { "filename" },
			-- 	lualine_x = { "location" },
			-- 	lualine_y = {},
			-- 	lualine_z = {},
			-- },
			-- tabline = {},
			-- winbar = {},
			-- inactive_winbar = {},
			-- extensions = {},
		})
	end,
}

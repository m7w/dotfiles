local M = {}

function M.sf_project_dir()
	local root_dir = vim.fs.dirname(
		vim.fs.find(
			{ "sfdx-project.json" },
			{ upward = true, stop = vim.uv.os_homedir(), start = vim.fs.dirname(vim.api.nvim_buf_get_name(0)) }
		)[1]
	)
	return root_dir
end

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	pattern = "*.cmp",
	group = vim.api.nvim_create_augroup("salesforce", { clear = true }),
	callback = function()
		local root_dir = M.sf_project_dir()

		if root_dir ~= nil then
			local buf = vim.api.nvim_get_current_buf()
			-- vim.api.nvim_buf_set_option(buf, "filetype", "html")
			vim.lsp.start({
				name = "aura_ls",
				-- npm i -D aura-language-server
				cmd = {
					vim.fn.getcwd() .. "/node_modules/.bin/aura-language-server",
					"--stdio",
				},
				root_dir = root_dir,
			})
		end
	end,
})

return M

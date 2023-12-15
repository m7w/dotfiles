local M = {}

local util = require("lspconfig.util")

local build_dir = "build"

local function stop_build()
	local bufnr = vim.api.nvim_get_current_buf()
	local texlab_client = util.get_active_client_by_name(bufnr, "texlab")
	local params = {
		command = "texlab.cancelBuild",
		arguments = {},
	}
	if texlab_client then
		texlab_client.request("workspace/executeCommand", params, function(err, _)
			if err then
				print(tostring(err))
			end
		end, bufnr)
	else
		print("method workspace/executeCommand is not supported by any servers active on the current buffer")
	end
end

local function get_environments()
	local bufnr = vim.api.nvim_get_current_buf()
	local texlab_client = util.get_active_client_by_name(bufnr, "texlab")
	local pos = vim.api.nvim_win_get_cursor(0)
	local params = {
		command = "texlab.findEnvironments",
		arguments = {
			{
				textDocument = { uri = vim.uri_from_bufnr(bufnr) },
				position = { line = pos[1] - 1, character = pos[2] },
			},
		},
	}
	if texlab_client then
		texlab_client.request("workspace/executeCommand", params, function(err, result)
			if err then
				print(tostring(err))
			end
			local envs = {}
			for _, r in ipairs(result) do
				table.insert(envs, {
					r.name.text .. ": " .. tonumber(r.name.range.start.line) + 1,
					{ tonumber(r.name.range.start.line) + 1, 0 },
				})
			end
			vim.ui.select(envs, {
				prompt = "Select environment:",
				format_item = function(item)
					return item[1]
				end,
			}, function(choice)
				vim.api.nvim_win_set_cursor(0, choice[2])
			end)
		end, bufnr)
	else
		print("method workspace/executeCommand is not supported by any servers active on the current buffer")
	end
end

local function load_log()
	vim.fn.setloclist(0, {}, "r")
	vim.cmd("laddfile " .. build_dir .. "/" .. vim.fn.expand("%:r") .. ".log")
end

local function qf_is_open()
	for _, wi in ipairs(vim.fn.getwininfo()) do
		if wi.loclist == 1 then
			return true
		end
	end
end

local function qf_toggle()
	if qf_is_open() then
		vim.cmd("lclose")
	else
		load_log()
		vim.cmd("lopen")
	end
end

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("texlab_attach", { clear = true }),
	callback = function()
		vim.api.nvim_create_user_command("TexlabStopBuild", stop_build, {})
		vim.api.nvim_create_user_command("TexlabToggleLog", qf_toggle, {})
		vim.api.nvim_create_user_command("TexlabEnvironments", get_environments, {})
	end,
})

function M.setup(opts)
	require("lspconfig").texlab.setup({
		on_attach = opts.on_attach,
		filetypes = { "tex", "plaintex", "bib", "sty" },
		settings = {
			texlab = {
				build = {
					auxDirectory = build_dir,
					logDirectory = build_dir,
					executable = "latexmk",
					args = {
						"-xelatex",
						"-auxdir=./" .. build_dir,
						"-outdir=./" .. build_dir,
						"-file-line-error",
						"-synctex=1",
						"-interaction=nonstopmode",
						"%f",
					},
					onSave = false,
					forwardSearchAfter = true,
				},
				chktex = {
					onOpenAndSave = true,
				},
				diagnosticsDelay = 300,
				formatterLineLength = 120,
				forwardSearch = {
					executable = "okular",
					args = {
						"--unique",
						"file:%p#src:%l%f",
					},
				},
			},
		},
	})
end

return M

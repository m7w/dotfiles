local M = {}

local function go_org_imports(wait_ms)
	local params = vim.lsp.util.make_range_params()
	params.context = { only = { "source.organizeImports" } }
	local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
	for cid, res in pairs(result or {}) do
		for _, r in pairs(res.result or {}) do
			if r.edit then
				local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
				vim.lsp.util.apply_workspace_edit(r.edit, enc)
			end
		end
	end
end

function M.setup(opts)
	local util = require("lspconfig.util")

	require("lspconfig").gopls.setup({
		cmd = { "gopls", "serve" },
		filetypes = { "go", "gomod" },
		on_attach = opts.on_attach,
		capabilities = opts.capabilities,
		root_dir = util.root_pattern("go.work", "go.mod", ".git"),
		settings = {
			gopls = {
				gofumpt = true,
				analyses = {
					unusedparams = true,
				},
				staticcheck = true,
				codelenses = {
					gc_details = false,
					generate = true,
					regenerate_cgo = true,
					run_govulncheck = true,
					test = true,
					tidy = true,
					upgrade_dependency = true,
					vendor = true,
				},
				hints = {
					assignVariableTypes = true,
					compositeLiteralFields = true,
					compositeLiteralTypes = true,
					constantValues = true,
					functionTypeParameters = true,
					parameterNames = true,
					rangeVariableTypes = true,
				},
			},
		},
	})

	vim.api.nvim_create_autocmd("BufWritePre", {
		pattern = "*.go",
		group = vim.api.nvim_create_augroup("go_org_imports", { clear = true }),
		callback = function()
			go_org_imports(1000)
		end,
	})

	vim.api.nvim_create_autocmd("FileType", {
		pattern = "go",
		group = vim.api.nvim_create_augroup("go_omnifunc", { clear = true }),
		command = "setlocal omnifunc=v:lua.vim.lsp.omnifunc",
	})
end

return M

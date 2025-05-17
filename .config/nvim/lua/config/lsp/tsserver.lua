local M = {}

function M.setup(opts)
	local vue_language_server_path = vim.fn.exepath("vue-language-server")

	local default_opts = {
		init_options = {
			preferences = {
				includeInlayParameterNameHints = "all",
				includeInlayParameterNameHintsWhenArgumentMatchesName = true,
				includeInlayFunctionParameterTypeHints = true,
				includeInlayVariableTypeHints = true,
				includeInlayPropertyDeclarationTypeHints = true,
				includeInlayFunctionLikeReturnTypeHints = true,
				includeInlayEnumMemberValueHints = true,
				importModuleSpecifierPreference = "non-relative",
			},
			plugins = {
				{
					name = "@vue/typescript-plugin",
					location = vue_language_server_path,
					languages = { "vue" },
				},
			},
		},
		filetypes = {
			"javascript",
			"typescript",
			"javascriptreact",
			"typescriptreact",
			"vue",
		},
	}

	local merged_config = vim.tbl_deep_extend("force", default_opts, opts or {})
	require("lspconfig").ts_ls.setup(merged_config)
end

return M

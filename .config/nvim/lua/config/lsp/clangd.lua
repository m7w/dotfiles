local M = {}

function M.setup(opts)
	require("lspconfig").clangd.setup({
		cmd = {
			"clangd",
			"--background-index",
			"--header-insertion=iwyu",
			"--clang-tidy",
			"--completion-style=detailed",
			"--function-args-placeholders",
			"--fallback-style=llvm",
			-- "--query-driver=/home/max/.platformio/packages/toolchain-xtensa-esp32/bin/xtensa-esp32-elf-gcc",
		},
		format = {
			indentWidth = 4,
		},
		filetypes = { "c", "cpp" },
		on_attach = opts.on_attach,
		capabilities = opts.capabilities,
	})
end

return M

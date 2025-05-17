local M = {}

--- Run the `javap -p` tool in a terminal buffer.
--- Sets the classpath based on the current project.
function M.javap_private()
	require("jdtls.util").with_classpaths(function(resp)
		local classname = require("jdtls.util").resolve_classname()
		local cp = table.concat(resp.classpaths, ":")
		local buf = vim.api.nvim_create_buf(false, true)
		vim.api.nvim_win_set_buf(0, buf)
		vim.fn.jobstart({ "javap", "-p", "--class-path", cp, classname }, { term = true })
	end)
end

vim.api.nvim_create_user_command("JdtPrivate", [[lua require("config.lsp.jdtls").javap_private()]], {})

function M.setup()
	local on_attach = function(client, bufnr)
		-- Show current content
		require("nvim-navic").attach(client, bufnr)

		-- Remove annoying jdt:// links in hover in java files
		local orig_open_floating_preview = vim.lsp.util.open_floating_preview
		vim.lsp.util.open_floating_preview = function(contents, syntax, opts)
			for i, line in ipairs(contents) do
				local sanitized_line = line:gsub("%(jdt://[^%)]*%)", "")
				contents[i] = sanitized_line
			end
			return orig_open_floating_preview(contents, syntax, opts)
		end

		-- vim.api.nvim_create_autocmd("BufWritePre", {
		-- 	group = vim.api.nvim_create_augroup("java_organize_imports", { clear = true }),
		-- 	pattern = "*.java",
		-- 	callback = function()
		-- 		require("jdtls").organize_imports()
		-- 	end,
		-- })

		vim.api.nvim_set_option_value("omnifunc", "v:lua.vim.lsp.omnifunc", { buf = bufnr })

		-- Mappings.
		-- Common
		require("config.lsp.keymaps").setup(client, bufnr)

		-- Java specific
		local opts = { noremap = true, silent = true }
		local function buf_set_keymap(...)
			vim.api.nvim_buf_set_keymap(bufnr, ...)
		end

		buf_set_keymap("n", "<leader>di", "<Cmd>lua require('jdtls').organize_imports()<CR>", opts)
		buf_set_keymap("n", "<leader>dt", "<Cmd>lua require('jdtls').test_class()<CR>", opts)
		buf_set_keymap("n", "<leader>dn", "<Cmd>lua require('jdtls').test_nearest_method()<CR>", opts)
		buf_set_keymap("v", "<leader>de", "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>", opts)
		buf_set_keymap("n", "<leader>de", "<Cmd>lua require('jdtls').extract_variable()<CR>", opts)
		buf_set_keymap("v", "<leader>dm", "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>", opts)

		-- Debugger
		require("jdtls").setup_dap({ hotcodereplace = "auto" })
	end

	local root_markers = { "build.gradle", "pom.xml", "gradlew", "mvnw", ".git" }
	local root_dir = require("jdtls.setup").find_root(root_markers)

	local capabilities = {
		workspace = {
			configuration = true,
		},
		textDocument = {
			completion = {
				completionItem = {
					snippetSupport = true,
				},
			},
		},
	}
	capabilities = vim.tbl_deep_extend(
		"force",
		vim.lsp.protocol.make_client_capabilities(),
		require("lsp-file-operations").default_capabilities()
	)

	local workspace_folder = vim.fn.expand("$MASON/jdtls/workspace/") .. vim.fn.fnamemodify(root_dir, ":p:h:t")

	local config = {
		flags = {
			allow_incremental_sync = true,
		},
		capabilities = capabilities,
		on_attach = on_attach,
	}

	config.settings = {
		java = {
			configuration = {
				runtimes = {
					name = "JavaSE-21",
					path = "/usr/lib64/jvm/java-21-openjdk-21/",
					default = true,
				},
			},
			signatureHelp = { enabled = true },
			completion = {
				favoriteStaticMembers = {
					"org.hamcrest.MatcherAssert.assertThat",
					"org.hamcrest.Matchers.*",
					"org.hamcrest.CoreMatchers.*",
					"org.junit.jupiter.api.Assertions.*",
					"java.util.Objects.requireNonNull",
					"java.util.Objects.requireNonNullElse",
					"org.mockito.Mockito.*",
				},
			},
			sources = {
				organizeImports = {
					starThreshold = 100,
					staticStarThreshold = 100,
				},
			},
			inlayHints = {
				parameterNames = {
					enabled = "all",
				},
			},
			codeGeneration = {
				toString = {
					template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
				},
			},
		},
	}
	config.cmd = {
		"java",
		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-Dlog.protocol=true",
		"-Dlog.level=ALL",
		"-Xmx4g",
		"-javaagent:" .. vim.fn.expand("$MASON/packages/jdtls/lombok.jar"),
		"--add-modules=ALL-SYSTEM",
		"--add-opens",
		"java.base/java.util=ALL-UNNAMED",
		"--add-opens",
		"java.base/java.lang=ALL-UNNAMED",
		"-jar",
		vim.fn.glob("$MASON/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"),
		"-configuration",
		vim.fn.expand("$MASON/packages/jdtls/config_linux"),
		"-data",
		workspace_folder,
	}
	config.on_attach = on_attach
	config.on_init = function(client, _)
		client.notify("workspace/didChangeConfiguration", { settings = config.settings })
	end

	local extendedClientCapabilities = require("jdtls").extendedClientCapabilities
	extendedClientCapabilities.resolveAdditionalTextEditsSupport = true
	extendedClientCapabilities.onCompletionItemSelectedCommand = "editor.action.triggerParameterHints"

	local bundles = {
		vim.fn.glob("$MASON/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar"),
	}

	vim.list_extend(bundles, vim.split(vim.fn.glob("$MASON/packages/java-test/extension/server/*.jar"), "\n"))

	config.init_options = {
		extendedClientCapabilities = extendedClientCapabilities,
		bundles = bundles,
	}

	-- Server
	require("jdtls").start_or_attach(config)
end

return M

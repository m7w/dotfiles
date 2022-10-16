local M = {}

function M.setup()
    local on_attach = function(client, bufnr)
        local function buf_set_keymap(...)
            vim.api.nvim_buf_set_keymap(bufnr, ...)
        end

        local function buf_set_option(...)
            vim.api.nvim_buf_set_option(bufnr, ...)
        end

        buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

        -- Mappings.
        -- Common
        require("config.lsp.keymaps").setup(client, bufnr)

        -- Java specific
        local opts = { noremap = true, silent = true }
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
    local home = os.getenv("HOME")

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

    local workspace_folder = home
        .. "/.local/share/nvim/mason/jdtls/workspace/"
        .. vim.fn.fnamemodify(root_dir, ":p:h:t")

    local config = {
        flags = {
            allow_incremental_sync = true,
        },
        capabilities = capabilities,
        on_attach = on_attach,
    }

    config.settings = {
        java = {
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
                    starThreshold = 9999,
                    staticStarThreshold = 9999,
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
        "-javaagent:" .. home .. "/.local/share/nvim/mason/packages/jdtls/lombok.jar",
        "--add-modules=ALL-SYSTEM",
        "--add-opens",
        "java.base/java.util=ALL-UNNAMED",
        "--add-opens",
        "java.base/java.lang=ALL-UNNAMED",
        "-jar",
        vim.fn.glob(home .. "/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"),
        "-configuration",
        home .. "/.local/share/nvim/mason/packages/jdtls/config_linux",
        "-data",
        workspace_folder,
    }
    config.on_attach = on_attach
    config.on_init = function(client, _)
        client.notify("workspace/didChangeConfiguration", { settings = config.settings })
    end

    local extendedClientCapabilities = require("jdtls").extendedClientCapabilities
    extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

    local bundles = {
        vim.fn.glob(home .. [[/.local/share/nvim/mason/packages/java-debug-adapter/extension/server
            /com.microsoft.java.debug.plugin-*.jar]]),
    }

    vim.list_extend(
        bundles,
        vim.split(vim.fn.glob(home .. "/.local/share/nvim/mason/packages/java-test/extension/server/*.jar"), "\n")
    )

    config.init_options = {
        extendedClientCapabilities = extendedClientCapabilities,
        bundles = bundles,
    }

    -- UI
    local finders = require("telescope.finders")
    local sorters = require("telescope.sorters")
    local actions = require("telescope.actions")
    local pickers = require("telescope.pickers")
    require("jdtls.ui").pick_one_async = function(items, prompt, label_fn, cb)
        local opts = {}
        pickers
            .new(opts, {
                prompt_title = prompt,
                finder = finders.new_table({
                    results = items,
                    entry_maker = function(entry)
                        return {
                            value = entry,
                            display = label_fn(entry),
                            ordinal = label_fn(entry),
                        }
                    end,
                }),
                sorter = sorters.get_generic_fuzzy_sorter(),
                attach_mappings = function(prompt_bufnr)
                    actions.goto_file_selection_edit:replace(function()
                        local selection = actions.get_selected_entry(prompt_bufnr)
                        actions.close(prompt_bufnr)

                        cb(selection.value)
                    end)

                    return true
                end,
            })
            :find()
    end

    -- Server
    require("jdtls").start_or_attach(config)
end

return M

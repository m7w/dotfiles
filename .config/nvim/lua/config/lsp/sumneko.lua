local M = {}

function M.setup(opts)
    local default_opts = {
        settings = {
            Lua = {
                runtime = {
                    version = 'LuaJIT',
                },
                diagnostics = {
                    -- Get the language server to recognize the `vim` global
                    globals = { 'vim' },
                },
                workspace = {
                    -- Make the server aware of Neovim runtime files
                    library = vim.api.nvim_get_runtime_file("", true),
                },
                telemetry = {
                    enable = false,
                },
            },
        },
    }

    local merged_opts = vim.tbl_deep_extend("force", default_opts, opts or {})
    require('lspconfig').sumneko_lua.setup(merged_opts)
end

return M

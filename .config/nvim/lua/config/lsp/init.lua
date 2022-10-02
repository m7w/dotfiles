local M = {}

local lsp = require('lspconfig')

-- Diagnostic options, see: `:help vim.diagnostic.config`
vim.diagnostic.config({
    update_in_insert = false,
    severity_sort = true,
    float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
    },
})

-- Show line diagnostics automatically in hover window
vim.api.nvim_create_autocmd(
    { 'CursorHold', 'CursorHoldI' },
    { pattern = '*',
        callback = function()
            vim.diagnostic.open_float(nil, { focus = false })
        end
    })

local function on_attach(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    vim.api.nvim_buf_set_option(0, 'formatexpr', 'v:lua.vim.lsp.formatexp')

    -- setup keymappings
    require('config.lsp.keymaps').setup(client, bufnr)
    -- setup available formatters
    require('config.lsp.null-ls.formatters').setup(client, bufnr)
end

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

capabilities.textDocument.completion.completionItem.documentationFormat = { 'markdown', 'plaintext' }
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.preselectSupport = true
capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
capabilities.textDocument.completion.completionItem.deprecatedSupport = true
capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
        'documentation',
        'detail',
        'additionalTextEdits',
    },
}

local float = {
    focusable = true,
    style = 'minimal',
    border = 'rounded'
}

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, float)
vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, float)

local servers = {
    'clangd',
    'cssls',
    'html',
    'pyright',
    'svelte',
    'tailwindcss',
    -- 'texlab',
}

function M.setup()
    local opts = {
        on_attach = on_attach,
        capabilities = capabilities,
        flags = {
            debounce_text_changes = 150,
        }
    }

    for _, server in ipairs(servers) do
        lsp[server].setup(opts)
    end

    -- Vue & javascript/typescript
    require('config.lsp.volar').setup(opts)

    -- Lua
    require('config.lsp.sumneko').setup(opts)

    -- null-ls: formatters, linters, hover.
    require('config.lsp.null-ls').setup(opts)

    require("config.lsp.gopsl").setup(opts)
    require("config.lsp.texlab").setup(opts)
end

return M

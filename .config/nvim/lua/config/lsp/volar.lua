local M = {}

function M.setup(opts)
    local default_opts = {
        filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json' },
        init_options = {
            typescript = {
                serverPath = ''
            },
            languageFeatures = {
                implementation = true,
                references = true,
                definition = true,
                typeDefinition = true,
                callHierarchy = true,
                hover = true,
                rename = true,
                renameFileRefactoring = true,
                signatureHelp = true,
                codeAction = true,
                codeLens = true,
                -- not implemented - https://github.com/neovim/neovim/pull/15723
                semanticTokens = false,
                diagnostics = true,
                schemaRequestService = true,
                workspaceSymbol = true,
                completion = {
                    defaultTagNameCase = 'both',
                    defaultAttrNameCase = 'kebabCase',
                    getDocumentNameCasesRequest = false,
                    getDocumentSelectionRequest = false,
                },
            },
            documentFeatures = {
                selectionRange = true,
                foldingRange = true,
                linkedEditingRange = true,
                documentSymbol = true,
                documentColor = false,
                documentFormatting = {
                    defaultPrintWidth = 100,
                },
            }
        }
    }

    local merged_config = vim.tbl_deep_extend("force", default_opts, opts or {})
    require('lspconfig').volar.setup(merged_config)
end

return M

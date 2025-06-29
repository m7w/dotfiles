return {
  init_options = {
    -- vue = {
    -- 	hybridMode = false,
    -- },
    typescript = {
      -- tsdk = vim.fn.expand(
      -- 	"$HOME/.local/share/nvim/mason/packages/typescript-language-server/node_modules/typescript/lib"
      -- ),
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayVariableTypeHintsWhenTypeMatchesName = false,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
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
      semanticTokens = true,
      diagnostics = true,
      schemaRequestService = true,
      workspaceSymbol = true,
      completion = {
        defaultTagNameCase = "both",
        defaultAttrNameCase = "kebabCase",
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
    },
  },
}

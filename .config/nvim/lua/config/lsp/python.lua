vim.lsp.config.basedpyright = {
  settings = {
    basedpyright = {
      analysis = {
        diagnosticMode = "workspace",
        autoSearchPaths = true,
        autoImportCompletions = true,
        typeCheckingMode = "standard",
        diagnosticSeverityOverrides = {
          reportArgumentType = false,
          -- reportAttributeAccessIssue = false,
        },
      },
    },
  },
}

vim.lsp.enable("basedpyright")

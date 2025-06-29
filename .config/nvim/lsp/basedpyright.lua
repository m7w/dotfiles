return {
  settings = {
    basedpyright = {
      analysis = {
        diagnosticMode = "workspace",
        autoSearchPaths = true,
        autoImportCompletions = true,
        useLibraryCodeForTypes = true,
        typeCheckingMode = "standard",
        diagnosticSeverityOverrides = {
          reportArgumentType = false,
          -- reportAttributeAccessIssue = false,
        },
      },
    },
  },
}

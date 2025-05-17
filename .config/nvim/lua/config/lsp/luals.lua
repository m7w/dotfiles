vim.lsp.config.luals = {
  settings = {
    Lua = {
      diagnostic = {
        globals = { "vim" },
      },
      completion = {
        keywordSnippet = "Replace",
        callSnippet = "Replace",
      },
      workspace = {
        checkThirdParty = false,
      },
      telemetry = {
        enable = false,
      },
      hint = {
        enable = true,
      },
    },
  },
}

vim.lsp.enable("luals")

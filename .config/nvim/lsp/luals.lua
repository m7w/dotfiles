return {
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
        library = {
          vim.env.VIMRUNTIME,
          "${3rd}/luv/library",
        },
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

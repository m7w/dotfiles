vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "go",
  group = vim.api.nvim_create_augroup("go_org_imports", { clear = true }),
  callback = function()
    vim.lsp.buf.format()
    vim.lsp.buf.code_action({ context = { only = { "source.organizeImports" } }, apply = true })
    vim.lsp.buf.code_action({ context = { only = { "source.fixAll" } }, apply = true })
  end,
})

return {
  settings = {
    gopls = {
      gofumpt = true,
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
      codelenses = {
        gc_details = false,
        generate = true,
        regenerate_cgo = true,
        run_govulncheck = true,
        test = true,
        tidy = true,
        upgrade_dependency = true,
        vendor = true,
      },
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
    },
  },
}

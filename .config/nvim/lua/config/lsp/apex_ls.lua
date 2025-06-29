local M = {}

function M.setup(opts)
  local default_opts = {
    on_attach = opts.on_attach,
    capabilities = opts.capabilities,
    filetypes = { "apex", "apexcode" },
    apex_jar_path = vim.fn.expand("$MASON/packages/apex-language-server/extension/dist/apex-jorje-lsp.jar"),
    apex_enable_semantic_errors = false, -- Whether to allow Apex Language Server to surface semantic errors
    apex_enable_completion_statistics = false, -- Whether to allow Apex Language Server to collect telemetry on code completion usage
  }

  local merged_config = vim.tbl_deep_extend("force", default_opts, opts or {})
  require("lspconfig").apex_ls.setup(merged_config)
  local ft = require("Comment.ft")
  ft({ "apex", "apexcode" }, { "//%s", "/*%s*/" })
end

return M

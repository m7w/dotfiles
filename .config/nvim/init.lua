if vim.g.vscode then
  require("vscode")
else
  require("keymaps")
  require("settings")
  require("config.lazy")
  require("config.salesforce")
  require("autocommands")

  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("lsp", { clear = true }),
    callback = function(args)
      require("config.lsp.keymaps").setup(args.data.client_id, args.buf)

      vim.diagnostic.config({
        update_in_insert = false,
        severity_sort = true,
        float = {
          focusable = false,
          style = "minimal",
          border = "rounded",
          source = "if_many",
          header = "",
          prefix = "",
        },

        signs = {
          active = true,
          text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.INFO] = " ",
            [vim.diagnostic.severity.HINT] = " ",
          },
          numhl = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.HINT] = "",
            [vim.diagnostic.severity.INFO] = "",
          },
        },
      })
    end,
  })

  vim.lsp.config("*", {
    capabilities = require("blink.cmp").get_lsp_capabilities(),
    root_markers = { ".git" },
  })

  require("config.lsp.python")
  require("config.lsp.luals")
  -- require("langmapper").automapping({ global = true, buffer = true })
end

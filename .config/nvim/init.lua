if vim.g.vscode then
  require("vscode")
else
  require("keymaps")
  require("settings")
  require("config.lazy")
  require("config.salesforce")
  require("autocommands")
  require("lsp")
  -- require("langmapper").automapping({ global = true, buffer = true })
end

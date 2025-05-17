local M = {}

local lsp = require("lspconfig")

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

vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
  pattern = "*",
  group = vim.api.nvim_create_augroup("auto_diagnostics", { clear = true }),
  callback = function()
    vim.diagnostic.open_float({ focus = false })
  end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    require("config.lsp.keymaps").setup(args.data.client_id, args.buf)
  end,
})

local function on_attach(client, bufnr)
  if client.server_capabilities.documentSymbolProvider then
    require("nvim-navic").attach(client, bufnr)
  end

  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_set_option_value("omnifunc", "v:lua.vim.lsp.omnifunc", { buf = bufnr })
  vim.api.nvim_set_option_value("formatexpr", "v:lua.vim.lsp.formatexpr", { buf = bufnr })
end

local float = {
  focusable = true,
  style = "minimal",
  border = "rounded",
}

vim.lsp.handlers["textDocument/hover"] = vim.lsp.buf.hover(float)
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.buf.signature_help(float)

local servers = {
  "clangd",
  "cssls",
  -- "gradle_ls",
  "helm_ls",
  "html",
  "lemminx",
  "lwc_ls",
  "ruff",
  "svelte",
}

function M.setup()
  local capabilities
  lsp.util.default_config = vim.tbl_extend("force", lsp.util.default_config, {
    capabilities = vim.tbl_deep_extend(
      "force",
      vim.lsp.protocol.make_client_capabilities(),
      require("lsp-file-operations").default_capabilities()
    ),
  })

  -- capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
  capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)

  local opts = {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = {
      debounce_text_changes = 150,
    },
  }

  -- for _, server in ipairs(servers) do
  --   lsp[server].setup(opts)
  -- end
  --
  -- require("config.lsp.jsonls").setup(opts)
  -- require("config.lsp.gopls").setup(opts)
  -- require("config.lsp.groovy").setup(opts)
  -- require("config.lsp.lua_ls").setup(opts)
  -- require("config.lsp.eslint").setup(opts)
  -- require("config.lsp.tsserver").setup(opts)
  -- require("config.lsp.volar").setup(opts)
  -- require("config.lsp.texlab").setup(opts)
  -- require("config.lsp.python").setup(opts)
  -- require("config.lsp.yamlls").setup(opts)
  -- require("config.lsp.apex_ls").setup(opts)
  -- require("config.lsp.visualforce_ls").setup(opts)
  -- require("config.lsp.tailwindcss").setup(opts)
end

return M

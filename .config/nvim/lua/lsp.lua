local M = {}

function M.set_lsp_keymaps(_, bufnr)
  local map = vim.keymap.set
  local opts = { noremap = true, silent = true, buffer = bufnr }
  local float = {
    focusable = true,
    style = "minimal",
    border = "rounded",
  }

  -- remove default lsp gr* mappings
  map("n", "gr", "<nop>", opts)

  map("n", "K", function()
    vim.lsp.buf.hover(float)
  end, opts)
  map("i", "<c-k>", function()
    vim.lsp.buf.signature_help(float)
  end, opts)
  map("n", "gD", "<cmd>lua Snacks.picker.lsp_declarations()<CR>", opts)
  map("n", "gd", "<cmd>lua Snacks.picker.lsp_definitions()<CR>", opts)
  map("n", "gy", "<cmd>lua Snacks.picker.lsp_type_definitions()<CR>", opts)
  map("n", "gr", "<cmd>lua Snacks.picker.lsp_references()<CR>", opts)
  map("n", "gi", "<cmd>lua Snacks.picker.lsp_implementations()<CR>", opts)
  map("n", "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
  map("n", "<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
  map("n", "<leader>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
  map("n", "<leader>rn", "<cmd>lua require('live-rename').rename({insert=true})<CR>", opts)
  map("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
  map("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
  map("n", "[e", "<cmd>lua vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })<CR>", opts)
  map("n", "]e", "<cmd>lua vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })<CR>", opts)
  map("n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
  map("n", "<leader>cf", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", opts)
  map("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  map("n", "<leader>cl", "<cmd>LspInfo<CR>", opts)
  map("n", "<leader>ts", "<cmd>lua require('symbol-usage').toggle()<CR>", opts)
end

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp", { clear = true }),
  callback = function(args)
    local client_id = args.data.client_id
    local client = assert(vim.lsp.get_client_by_id(client_id))
    local bufnr = args.buf

    M.set_lsp_keymaps(client_id, bufnr)

    if client.server_capabilities.documentSymbolProvider then
      require("nvim-navic").attach(client, bufnr)
    end

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
          [vim.diagnostic.severity.INFO] = "󰋼 ",
          [vim.diagnostic.severity.HINT] = "󰌵 ",
        },
      },
    })
  end,
})

vim.lsp.enable("eslint")

vim.lsp.config("*", {
  capabilities = require("blink.cmp").get_lsp_capabilities(vim.lsp.protocol.make_client_capabilities()),
  root_markers = { ".git" },
})

return M

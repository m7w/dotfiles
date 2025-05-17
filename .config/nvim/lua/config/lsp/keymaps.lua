local M = {}

function M.setup(_, bufnr)
  local map = vim.keymap.set
  local opts = { noremap = true, silent = true, buffer = bufnr }

  -- remove default lsp gr* mappings
  map("n", "gr", "<nop>", opts)

  map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  map("i", "<c-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  map("n", "gD", "<cmd>lua Snacks.picker.lsp_declarations()<CR>", opts)
  map("n", "gd", "<cmd>lua Snacks.picker.lsp_definitions()<CR>", opts)
  map("n", "gy", "<cmd>lua Snacks.picker.lsp_type_definitions()<CR>", opts)
  map("n", "gr", "<cmd>lua Snacks.picker.lsp_references()<CR>", opts)
  map("n", "gi", "<cmd>lua Snacks.picker.lsp_implementations()<CR>", opts)
  map("n", "<leader>rn", "<cmd>lua require('live-rename').rename({insert=true})<CR>", opts)
  -- map("n", "<leader>n", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  map("n", "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
  map("n", "<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
  map("n", "<leader>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
  -- map("n", "<leader>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
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

return M

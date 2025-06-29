local build_dir = "build"

local function load_log()
  vim.fn.setloclist(0, {}, "r")
  vim.cmd("laddfile " .. vim.fn.expand("%:r") .. build_dir .. "/" .. vim.fn.expand("%:r") .. ".log")
end

local function qf_is_open()
  for _, wi in ipairs(vim.fn.getwininfo()) do
    if wi.loclist == 1 then
      return true
    end
  end
end

local function qf_toggle()
  if qf_is_open() then
    vim.cmd("lclose")
  else
    load_log()
    vim.cmd("lopen")
  end
end

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("texlab_attach", { clear = true }),
  callback = function()
    vim.api.nvim_create_user_command("LspTexlabToggleLog", qf_toggle, {})
  end,
})

return {
  filetypes = { "tex", "plaintex", "bib", "sty" },
  settings = {
    texlab = {
      build = {
        auxDirectory = build_dir,
        logDirectory = build_dir,
        executable = "latexmk",
        args = {
          "-xelatex",
          "-auxdir=./" .. build_dir,
          "-outdir=./" .. build_dir,
          "-file-line-error",
          "-synctex=1",
          "-interaction=nonstopmode",
          "%f",
        },
        onSave = false,
        forwardSearchAfter = true,
      },
      chktex = {
        onOpenAndSave = true,
      },
      diagnosticsDelay = 300,
      formatterLineLength = 120,
      forwardSearch = {
        executable = "okular",
        args = {
          "--unique",
          "file:%p#src:%l%f",
        },
      },
    },
  },
}

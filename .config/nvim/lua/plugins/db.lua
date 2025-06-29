return {
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { "tpope/vim-dadbod", cmd = "DB", lazy = true },
      { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
    },
    ft = { "sql", "mysql", "plsql" },
    event = "VeryLazy",
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1
      vim.g.db_ui_execute_on_save = 0
      -- Enable Oracle Legacy Mode
      vim.g.db_ui_is_oracle_legacy = 1
      -- Use Oracle SQLcl
      vim.g.db_ui_use_sqlplus = 0
      vim.g.dbext_default_ORA_bin = "sql"
      -- vim.g.db_ui_save_location = "~/dev/sql/db_ui_queries/"
    end,
  },
}

return {
  -- { dir = "~/dev/nvim/plugins/pio" },
  -- {
  -- 	"supermaven-inc/supermaven-nvim",
  -- 	opts = {
  -- 		keymaps = {
  -- 			accept_suggestion = "<C-[>",
  -- 			clear_suggestion = "<C-]>",
  -- 			accept_word = "<C-j>",
  -- 		},
  -- 	},
  -- },
  { dir = "~/dev/nvim/plugins/sf" },
  -- Appearance
  -- Colorschemes
  {
    "ellisonleao/gruvbox.nvim",
    lazy = true,
    enabled = true,
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = true,
    opts = {
      statementStyle = { italic = true },
    },
    enabled = true,
  },
  {
    "catppuccin/nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavor = "macchiato",
        styles = {
          loops = { "italic" },
        },
        integrations = {
          blink_cmp = true,
          fidget = true,
          mason = true,
          navic = {
            enabled = true,
            custom_bg = "NONE",
          },
          notify = true,
          snacks = true,
          which_key = true,
        },
      })
      vim.cmd("colorscheme catppuccin")
    end,
    enabled = true,
  },

  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {},
  },

  -- UI
  { "nvim-tree/nvim-web-devicons", lazy = true },
  { "SmiteshP/nvim-navic", opts = { highlight = true } },
  {
    "j-hui/fidget.nvim",
    opts = {
      notification = {
        window = {
          winblend = 0,
        },
      },
    },
  },
  { "stevearc/dressing.nvim", event = "VeryLazy" },
  {
    "catgoose/nvim-colorizer.lua",
    opts = {
      user_default_options = {
        tailwind = true,
      },
    },
  },
  {
    "Pocco81/true-zen.nvim",
    opts = {
      modes = {
        ataraxis = {
          minimum_writing_area = {
            width = 100,
          },
        },
      },
      integrations = {
        twilight = true,
        lualine = true,
      },
    },
  },
  {
    "folke/twilight.nvim",
    config = true,
  },
  {
    "rcarriga/nvim-notify",
    config = function()
      vim.notify = require("notify")
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      -- show_deleted = true,
      diff_opts = {
        algorithm = "histogram",
      },
    },
  },
  "sindrets/diffview.nvim",

  -- Useful plugins related to keys
  {
    "m4xshen/hardtime.nvim",
    dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
    opts = {
      disabled_filetypes = { "qf", "NvimTree", "lazy", "mason", "oil", "maven" },
      disable_mouse = false,
      hints = {
        ["[dcyvV][ia][%(%)]"] = {
          message = function(keys)
            return "Use " .. keys:sub(1, 2) .. "b instead of " .. keys
          end,
          length = 3,
        },
      },
    },
  },
  {
    "ggandor/flit.nvim",
    opts = {
      labeled_modes = "nv",
      multiline = false,
    },
    dependencies = {
      {
        "ggandor/leap.nvim",
        config = function()
          require("leap").add_default_mappings(true)
          vim.keymap.del({ "x", "o" }, "x")
          vim.keymap.del({ "x", "o" }, "X")
        end,
      },
      "tpope/vim-repeat",
    },
  },
  {
    "numToStr/Comment.nvim",
    config = true,
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
  },
  {
    "folke/ts-comments.nvim",
    opts = {
      lang = {
        apex = { "// %s", "/* %s */" },
        apexcode = { "// %s", "/* %s */" },
      },
    },
    event = "VeryLazy",
  },
  {
    "kylechui/nvim-surround",
    config = true,
  },
  {
    "XXiaoA/ns-textobject.nvim",
    config = true,
  },
  {
    "Wansmer/sibling-swap.nvim",
    dependencies = { "nvim-treesitter" },
    opts = {},
  },

  -- Docs
  {
    "danymat/neogen",
    opts = { snippet_engine = "luasnip" },
  },

  -- LSP
  {
    "neovim/nvim-lspconfig",
    --   config = function()
    --     require("config.lsp").setup()
    --   end,
  },
  {
    "williamboman/mason.nvim",
    -- version = "^1.0.0",
    config = true,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    -- version = "^1.0.0",
    config = true,
  },
  "mfussenegger/nvim-jdtls",
  {
    "saecki/live-rename.nvim",
    opts = {
      keys = {
        cancel = {
          { "n", "<Esc>" },
          { "n", "q" },
          { "i", "<C-c>" },
        },
      },
    },
  },
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "snacks.nvim", words = { "Snacks" } },
      },
    },
  },
  {
    "Wansmer/symbol-usage.nvim",
    event = "LspAttach",
    opts = {
      vt_position = "textwidth",
      definition = { enabled = false },
      implementation = { enabled = false },
      text_format = function(symbol)
        local res = {}

        if symbol.references then
          local usage = symbol.references <= 1 and "usage" or "usages"
          local num = symbol.references == 0 and "no" or symbol.references
          table.insert(res, { "󰌹 ", "SymbolUsageRef" })
          table.insert(res, { ("%s %s"):format(num, usage), "SymbolUsageContent" })
        end

        return res
      end,
    },
  },

  {
    "jonathanmorris180/salesforce.nvim",
    config = function()
      require("salesforce").setup({
        popup = {
          width = 140,
        },
      })
    end,
  },

  -- Debuggers
  {
    "mfussenegger/nvim-dap",
    config = function()
      local sign = vim.fn.sign_define
      sign("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
      sign("DapBreakpointCondition", { text = "●", texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
      sign("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "" })

      require("config.dap.python").setup()
      require("config.dap.go").setup()
    end,
  },
  {
    "miroshQa/debugmaster.nvim",
    config = function()
      local dm = require("debugmaster")
      -- make sure you don't have any other keymaps that starts with "<leader>d" to avoid delay
      -- Alternative keybindings to "<leader>d" could be: "<leader>m", "<leader>;"
      vim.keymap.set({ "n", "v" }, "<leader>d", dm.mode.toggle, { nowait = true })
      -- If you want to disable debug mode in addition to leader+d using the Escape key:
      -- vim.keymap.set("n", "<Esc>", dm.mode.disable)
      -- This might be unwanted if you already use Esc for ":noh"
      vim.keymap.set("t", "<C-/>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
    end,
  },
  { "theHamsta/nvim-dap-virtual-text", config = true },
  { "LiadOz/nvim-dap-repl-highlights", config = true },
  { "nvim-neotest/nvim-nio" },

  -- Autopairs
  {
    "windwp/nvim-autopairs",
    opts = {
      check_ts = true,
    },
  },
  -- Autotag
  "windwp/nvim-ts-autotag",

  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    ft = { "markdown" },
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
      only_render_image_at_cursor = true,
    },
  },
  {
    "Nedra1998/nvim-mdlink",
    opts = {
      keymap = true,
      cmp = true,
    },
  },
  -- { "OXY2DEV/markview.nvim", lazy = false },

  "towolf/vim-helm",
  {
    "oclay1st/maven.nvim",
    cmd = { "Maven", "MavenInit", "MavenExec" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
    opts = {}, -- options, see default configuration
    keys = { { "<Leader>M", "<cmd>Maven<cr>", desc = "Maven" } },
  },
  "b0o/schemastore.nvim",
}

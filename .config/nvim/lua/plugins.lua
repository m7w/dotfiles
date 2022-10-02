local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({
        "git",
        "clone",
        "--depth", "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path
    })
    vim.cmd [[packadd packer.nvim]]
end

local packerGroup = vim.api.nvim_create_augroup("PackerGroup", { clear = true })
vim.api.nvim_create_autocmd(
    "BufWritePost",
    { pattern = "plugins.lua",
        command = "source <afile> | PackerCompile",
        group = packerGroup
    })

return require("packer").startup({
    function()
        -- Stop sumneko_lua be worried about undefined global "use"
        local use = require("packer").use

        use { "wbthomason/packer.nvim" }

        -- Appearance
        -- Colorschemes
        use {
            "ellisonleao/gruvbox.nvim",
            config = function()
                vim.cmd("colorscheme gruvbox")
            end,
            disable = false
        }
        use {
            "folke/tokyonight.nvim",
            config = function()
                vim.cmd("colorscheme tokyonight")
            end,
            disable = true
        }
        --------------------------------
        -- UI
        use { "kyazdani42/nvim-web-devicons" }

        use {
            "nvim-lualine/lualine.nvim",
            config = function()
                require("config.lualine").setup()
            end
        }
        use {
            "akinsho/bufferline.nvim", tag = "v2.*",
            config = function()
                require("config.bufferline").setup()
            end
        }

        use {
            "kyazdani42/nvim-tree.lua",
            config = function()
                require("config.nvim-tree").setup()
            end
        }

        use {
            "norcalli/nvim-colorizer.lua",
            config = function()
                require("colorizer").setup()
            end
        }

        use {
            "Pocco81/true-zen.nvim",
            config = function()
                require("true-zen").setup({
                    integrations = {
                        twilight = true,
                        lualine = true
                    },
                })
            end,
        }
        use {
            "folke/twilight.nvim",
            config = function()
                require("twilight").setup()
            end
        }

        use {
            "rcarriga/nvim-notify",
            config = function()
                vim.notify = require("notify")
            end
        }

        use {
            "lewis6991/gitsigns.nvim",
            config = function()
                require("gitsigns").setup()
            end
        }

        use {
            "akinsho/toggleterm.nvim", tag = "*",
            config = function()
                require("config.toggleterm").setup()
            end
        }

        -- Useful plugins related to keys
        use {
            "gukz/ftFT.nvim",
            config = function()
                require("ftFT").setup()
            end,
            lock = true
        }

        use {
            "numToStr/Comment.nvim",
            config = function()
                require("Comment").setup()
            end
        }
        use {
            "kylechui/nvim-surround",
            config = function()
                require("nvim-surround").setup()
            end
        }
        use {
            "folke/which-key.nvim",
            config = function()
                require("config.which-key").setup()
            end
        }


        -- LSP
        use { "jose-elias-alvarez/null-ls.nvim" }
        use {
            "neovim/nvim-lspconfig",
            config = function()
                require("config.lsp").setup()
            end
        }
        use {
            "williamboman/mason.nvim",
            config = function()
                require("mason").setup()
            end
        }
        use {
            "williamboman/mason-lspconfig.nvim",
            config = function()
                require("mason-lspconfig").setup()
            end
        }
        -- For Java LSP. Install and update jdtls using mason
        use {
            "mfussenegger/nvim-jdtls",
            ft = "java",
            config = function()
                require("config.lsp.jdtls").setup()
            end
        }
        use {
            "rcarriga/nvim-dap-ui",
            requires = { "mfussenegger/nvim-dap" }
        }
        -- For SQL LSP.
        -- lighttiger2505/sqls
        -- use { "nanotee/sqls.nvim" }
        -- Maybe use dadbod?


        -- Completion
        use {
            "hrsh7th/nvim-cmp",
            -- event = "InsertEnter",
            requires = {
                "hrsh7th/cmp-buffer",
                "hrsh7th/cmp-path",
                "hrsh7th/cmp-cmdline",
                "hrsh7th/cmp-nvim-lsp",
                "hrsh7th/cmp-nvim-lsp-signature-help",
                {
                    "L3MON4D3/LuaSnip",
                    config = function()
                        require("luasnip.loaders.from_vscode").lazy_load()
                    end
                },
                "saadparwaiz1/cmp_luasnip",
                "rafamadriz/friendly-snippets",
            },
            config = function()
                require("config.cmp").setup()
            end
        }
        -- Autopairs
        use {
            "windwp/nvim-autopairs",
            config = function()
                require("config.autopairs").setup()
            end
        }

        -- Telescope
        use {
            "nvim-telescope/telescope.nvim", tag = "0.1.0",
            config = function()
                require("config.telescope").setup()
            end,
            requires = {
                { "nvim-lua/plenary.nvim" },
                {
                    "nvim-telescope/telescope-fzf-native.nvim",
                    after = "telescope.nvim",
                    run = "make"
                },
                { "nvim-telescope/telescope-file-browser.nvim" },
                { "nvim-telescope/telescope-ui-select.nvim" },
                { "tknightz/telescope-termfinder.nvim" }
            }
        }

        -- Treesitter
        use {
            "nvim-treesitter/nvim-treesitter",
            -- event = "BufRead",
            run = ":TSUpdate",
            config = function()
                require("config.treesitter").setup()
            end,
            requires = {
                "nvim-treesitter/nvim-treesitter-refactor",
                "nvim-treesitter/nvim-treesitter-textobjects",
                "JoosepAlviste/nvim-ts-context-commentstring",
            },
        }

        use {
            "iamcco/markdown-preview.nvim",
            run = "cd app && npm install",
            setup = function()
                vim.g.mkdp_filetypes = { "markdown" }
            end,
            ft = { "markdown" },
        }

        if packer_bootstrap then
            require("packer").sync()
        end
    end,

    config = {
        display = {
            open_fn = function()
                return require("packer.util").float({ border = single })
            end
        }
    }
})

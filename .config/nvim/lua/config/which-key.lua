local M = {}

function M.setup()
    local wk = require("which-key")

    wk.register({
        ["<leader>"] = {
            f = {
                name = "Telescope",
                f = { "<cmd>Telescope find_files<CR>", "Find Files" },
                r = { "<cmd>Telescope oldfiles<CR>", "Open Recent File" },
                b = { "<cmd>Telescope buffers<CR>", "Find Buffers" },
                g = { "<cmd>Telescope live_grep<CR>", "Live Grep" },
                d = { "<cmd>Telescope diagnostics<CR>", "Open Diagnostic" },
                t = { "<cmd>Telescope treesitter<CR>", "Treesitter Tags" },
                s = { "<cmd>Telescope lsp_document_symbols<CR>", "LSP Symbols" },
            },
            z = {
                name = "True-Zen",
                a = { "<cmd>TZAtaraxis<CR>", "Ataraxis" },
                f = { "<cmd>TZFocus<CR>", "Focus" },
                m = { "<cmd>TZMinimalist<CR>", "Minimalist" },
            },
        },
    })
end

return M

local M = {}

function M.setup()
    vim.opt.termguicolors = true
    require("bufferline").setup({
        options = {
            mode = "tabs",
            numbers = function(opts)
                return string.format('%s·%s', opts.ordinal, opts.lower(opts.id))
            end,
            diagnostics = "nvim_lsp",
            diagnostics_update_in_insert = false,
            diagnostics_indicator = function(count, level, diagnostics_dict, context)
                local s = " "
                for e, n in pairs(diagnostics_dict) do
                    local sym = e == "error" and " "
                        or (e == "warning" and " " or "")
                    s = s .. n .. sym
                end
                return s
            end,
            offsets = {
                {
                    filetype = "NvimTree",
                    text = "File Explorer",
                    text_align = "left",
                    separator = true
                },

            },
            color_icons = false,
            show_tab_indicators = false,
            persist_buffer_sort = false,
            sort_by = "tabs",
        }
    })
end

return M

local M = {}

local nls = require("null-ls")
local nls_sources = require("null-ls.sources")

local method = nls.methods.FORMATTING

M.autoformat = true

function M.toggle()
    if M.autoformat then
        vim.notify("Enabled format on save", vim.log.levels.INFO, { title = "Fomatting" })
    else
        vim.notify("Disabled format on save", vim.log.levels.WARN, { title = "Fomatting" })
    end
    M.autoformat = not M.autoformat
end

function M.format()
    if M.autoformat then
        vim.lsp.buf.format()
    end
end

function M.has_formatter(filetype)
    local formatters = nls_sources.get_available(filetype, method)
    return #formatters > 0
end

function M.get_supported(filetype)
    local supported_formatters = nls_sources.get_supported(filetype, method)
    table.sort(supported_formatters)
    return supported_formatters
end

function M.get_registered(filetype)
    local registered_providers = require("config.lsp.null-ls.utils").get_registered_providers_names(filetype)
    return registered_providers[method] or {}
end

function M.setup(client, bufnr)
    local filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")

    local enable = false
    if M.has_formatter(filetype) then
        enable = client.name == "null-ls"
    else
        enable = not (client.name == "null-ls")
    end

    client.server_capabilities.document_formatting = enable
    client.server_capabilities.document_range_formatting = enable
    if client.server_capabilities.document_formatting then
        vim.api.nvim_create_augroup("lsp_format", { clear = true })
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = "lsp_format",
            buffer = bufnr,
            callback = function()
                M.format()
            end,
        })
    end
end

return M

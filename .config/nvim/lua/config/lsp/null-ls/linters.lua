local M = {}

local nls = require('null-ls')
local nls_sources = require("null-ls.sources")

local method = nls.methods.DIAGNOSTICS

function M.get_supported(filetype)
    local supported_linters = nls_sources.get_supported(filetype, method)
    table.sort(supported_linters)
    return supported_linters
end

function M.get_registered(filetype)
    local registered_providers = require('config.lsp.null-ls.utils')
        .get_registered_providers_names(filetype)
    return registered_providers[method] or {}
end

return M

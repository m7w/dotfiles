local M = {}

local nls = require('null-ls')
local nls_sources = require("null-ls.sources")

local method = nls.methods.CODE_ACTION

function M.get_supported(filetype)
    local supported_code_actions = nls_sources.get_supported(filetype, method)
    table.sort(supported_code_actions)
    return supported_code_actions
end

function M.get_registered(filetype)
    local registered_providers = require('config.lsp.null-ls.utils')
        .get_registered_providers_names(filetype)
    return registered_providers[method] or {}
end

return M

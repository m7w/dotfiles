local M = {}

function M.get_registered_providers_names(filetype)
    local nls = require("null-ls.sources")
    local available_sources = nls.get_available(filetype)
    local registered = {}
    for _, source in ipairs(available_sources) do
        for method, is_registered in pairs(source.methods) do
            if (is_registered) then
                registered[method] = registered[method] or {}
                table.insert(registered[method], source.name)
            end
        end
    end
    return registered
end

return M

local M = {}

local function lsp_client()
    local buf_clients = vim.lsp.buf_get_clients()

    if next(buf_clients) == nil then
        return ""
    end

    local buf_client_names = {}
    for _, client in pairs(buf_clients) do
        if client.name ~= "null-ls" then
            table.insert(buf_client_names, client.name)
        end
    end

    local formatters = require("config.lsp.null-ls.formatters")
        .get_registered(vim.bo.filetype)
    vim.list_extend(buf_client_names, formatters)

    local linters = require("config.lsp.null-ls.linters")
        .get_registered(vim.bo.filetype)
    vim.list_extend(buf_client_names, linters)

    local code_actions = require("config.lsp.null-ls.code_actions")
        .get_registered(vim.bo.filetype)
    vim.list_extend(buf_client_names, code_actions)

    return "[" .. table.concat(buf_client_names, ", ") .. "]"
end

local function lsp_progress(_, is_active)
    if not is_active then
        return
    end

    local messages = vim.lsp.util.get_progress_messages()
    if #messages == 0 then
        return ""
    end

    local status = {}
    local msg = messages[#messages]
    table.insert(status, (msg.percentage or 0) .. "%% " .. msg.title)

    local spinners = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
    local ms = vim.loop.hrtime() / 1000000
    local frame = math.floor(ms / 120) % #spinners

    return table.concat(status, "  ") .. " " .. spinners[frame + 1]
end

function M.setup()

    require("lualine").setup({
        options = {
            icons_enabled = true,
            theme = "auto",
            component_separators = { left = "", right = "" },
            section_separators = { left = " ", right = "" },
            disabled_filetypes = {},
            always_divide_middle = true,
        },
        sections = {
            lualine_a = { "mode" },
            lualine_b = { "branch", "diff", "diagnostics" },
            lualine_c = {
                { "filename" },
                { "%=" },
                { lsp_client, icon = " ", color = { fg = "#c678dd", gui = "bold" } },
                { lsp_progress },
            },
            lualine_x = { "encoding", "fileformat", "filetype" },
            lualine_y = { "progress" },
            lualine_z = { 'location' }
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = { 'filename' },
            lualine_x = { 'location' },
            lualine_y = {},
            lualine_z = {}
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {}
    })
end

return M

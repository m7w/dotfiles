local M = {}

local nls = require("null-ls")
local nls_sources = require("null-ls.sources")

local method = nls.methods.FORMATTING

M.autoformat = true

function M.toggle()
	M.autoformat = not M.autoformat
	if M.autoformat then
		vim.notify("Enabled format on save", vim.log.levels.INFO, { title = "Fomatting" })
	else
		vim.notify("Disabled format on save", vim.log.levels.WARN, { title = "Fomatting" })
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

function M.format(bufnr)
	if M.autoformat then
		vim.lsp.buf.format({
			filter = function(client)
				return client.name ~= "html"
			end,
			timeout_ms = 5000,
			bufnr = bufnr,
		})
	end
end

function M.setup(client, bufnr)
	local filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")

	local enable = false
	if M.has_formatter(filetype) then
		enable = client.name == "null-ls"
	else
		enable = not (client.name == "null-ls")
	end

	client.server_capabilities.documentFormattingProvider = enable
	client.server_capabilities.documentRangeFormattingProvider = enable
	if client.server_capabilities.documentFormattingProvider then
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = vim.api.nvim_create_augroup("lsp_format", { clear = true }),
			buffer = bufnr,
			callback = function()
				vim.notify("FORMATTING ON SAVE")
				M.format()
			end,
		})
	end
end

return M

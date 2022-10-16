-- Remove annoying jdt:// links in hover in java files
local orig_open_floating_preview = vim.lsp.util.open_floating_preview
vim.lsp.util.open_floating_preview = function(contents, syntax, opts)
	for i, line in ipairs(contents) do
		local sanitized_line = line:gsub("%(jdt://[^%)]*%)", "")
		contents[i] = sanitized_line
	end
	orig_open_floating_preview(contents, syntax, opts)
end

require("config.lsp.jdtls").setup()

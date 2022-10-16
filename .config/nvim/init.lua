local loaded, impatient = pcall(require, "impatient")
if loaded then
	impatient.enable_profile()
else
	vim.notify(impatient)
end

require("keymaps")
require("plugins")
require("settings")
require("autocommands")

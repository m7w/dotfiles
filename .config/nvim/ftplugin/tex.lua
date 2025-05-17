local cfg = require("nvim-surround.config")

local function starts_with(selection, start)
	local str = vim.api.nvim_buf_get_text(
		0,
		selection.first_pos[1] - 1,
		selection.first_pos[2] - 1,
		selection.last_pos[1] - 1,
		selection.last_pos[2],
		{}
	)
	return str[1]:sub(1, #start) == start
end

local function tex_find_environment()
	print("tex_find_environment was called")
	if vim.g.loaded_nvim_treesitter then
		local selection = cfg.get_selection({
			node = "generic_environment",
		})
		if selection then
			return selection
		end
	end
end

local function before(pos1, pos2)
	return pos1[1] < pos2[1] or pos1[1] == pos2[1] and pos1[2] <= pos2[2] + 1
end

local function tex_find_math()
	print("tex_find_math was called")
	local pos = vim.api.nvim_win_get_cursor(0)
	local math_variants = { "inline_formula", "displayed_equation", "math_environment" }
	if vim.g.loaded_nvim_treesitter then
		for _, math in ipairs(math_variants) do
			local selection = cfg.get_selection({
				node = math,
			})
			if selection then
				-- check if current cursor position get into a selection
				if before(selection.first_pos, pos) and before(pos, selection.last_pos) then
					return selection
				end
			end
		end
	end
end

require("nvim-surround").buffer_setup({
	surrounds = {
		["c"] = {
			add = function()
				local cmd = cfg.get_input("Command: ")
				return { { "\\" .. cmd .. "{" }, { "}" } }
			end,
			find = [=[\[^\{}%[%]]-%b{}]=],
			delete = [[^(\[^\{}]-{)().-(})()$]],
			change = {
				target = [[^\([^\{}]-)()%b{}()()$]],
				replacement = function()
					local cmd = cfg.get_input("Command: ")
					return { { cmd }, { "" } }
				end,
			},
		},
		["C"] = {
			add = function()
				local cmd, opts = cfg.get_input("Command: "), cfg.get_input("Options: ")
				return { { "\\" .. cmd .. "[" .. opts .. "]{" }, { "}" } }
			end,
			find = [[\[^\{}]-%b[]%b{}]],
			delete = [[^(\[^\{}]-%b[]{)().-(})()$]],
			change = {
				target = [[^\([^\{}]-)()%[(.*)()%]%b{}$]],
				replacement = function()
					local cmd, opts = cfg.get_input("Command: "), cfg.get_input("Options: ")
					return { { cmd }, { opts } }
				end,
			},
		},
		["e"] = {
			add = function()
				local env = cfg.get_input("Environment: ")
				return { { "\\begin{" .. env .. "}" }, { "\\end{" .. env .. "}" } }
			end,
			find = tex_find_environment,
			delete = [[^(\begin%b{})().*(\end%b{})()$]],
			change = {
				target = [[^\begin{(.-)()%}.*\end{(.-)()}$]],
				replacement = function()
					local env = require("nvim-surround.config").get_input("Environment: ")
					return { { env }, { env } }
				end,
			},
		},
		["E"] = {
			add = function()
				local env, opts = cfg.get_input("Environment: "), cfg.get_input("Options: ")
				return { { "\\begin{" .. env .. "}[" .. opts .. "]" }, { "\\end{" .. env .. "}" } }
			end,
			find = tex_find_environment,
			delete = [[^(\begin%b{}%b[])().*(\end%b{})()$]],
			change = {
				target = [[^\begin%b{}%[(.-)()()()%].*\end%b{}$]],
				replacement = function()
					local env = cfg.get_input("Environment options: ")
					return { { env }, { "" } }
				end,
			},
		},
		["$"] = {
			add = function()
				return { { "$ " }, { " $" } }
			end,
			find = tex_find_math,
			delete = function()
				local pattern
				local selection = tex_find_math()
				if selection then
					if starts_with(selection, "$") then
						pattern = "^(%$%s*)().-(%s*%$)()$"
					elseif starts_with(selection, "\\[") then
						pattern = "^(\\%[%s*)().-(%s*\\])()$"
					else
						pattern = "(\\begin{equation}%s*)().-(%s*\\end{equation})()"
					end
					return cfg.get_selections({
						char = "$",
						pattern = pattern,
					})
				else
					return nil
				end
			end,
			change = {
				target = function()
					local pattern
					local selection = tex_find_math()
					if selection then
						if starts_with(selection, "$") then
							pattern = "^(%$%s*)().-(%s*%$)()$"
						elseif starts_with(selection, "\\[") then
							pattern = "^(\\%[%s*)().-(%s*\\])()$"
						else
							pattern = "(\\begin{equation}%s*)().-(%s*\\end{equation})()"
						end
						return cfg.get_selections({
							char = "$",
							pattern = pattern,
						})
					else
						return nil
					end
				end,
				replacement = function()
					local selection = tex_find_math()
					if selection then
						if starts_with(selection, "$") then
							return { { "\\begin{equation} " }, { " \\end{equation}" } }
						elseif starts_with(selection, "\\[") then
							return { { "$ " }, { " $" } }
						else
							return { { "\\[ " }, { " \\]" } }
						end
					else
						return nil
					end
				end,
			},
		},
	},
})

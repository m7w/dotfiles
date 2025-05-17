local M = {}
function M.maven_dependency(groupId, artifactId, version)
	local g = "<groupId>" .. groupId .. "</groupId>"
	local a = "<artifactId>" .. artifactId .. "</artifactId>"
	local v = "<version>" .. version .. "</version>"
	return { "<dependency>", g, a, v, "</dependency>" }
end

function M.gradle_dependency(groupId, artifactId, version)
	local s = "implementation '" .. groupId .. ":" .. artifactId .. ":" .. version .. "'"
	return { s }
end

function M.insert_dependency()
	local artifact = vim.fn.expand("<cWORD>")
	local curl = require("plenary.curl")
	local response = curl.get("https://search.maven.org/solrsearch/select?q=" .. artifact .. "&wt=json")
	local body = vim.json.decode(response.body)
	local choises = {}
	for _, d in ipairs(body.response.docs) do
		table.insert(choises, d.g .. ":" .. d.a)
	end
	vim.ui.select(choises, {}, function(_, idx)
		if idx ~= nil then
			local g = body.response.docs[idx].g
			local a = body.response.docs[idx].a
			local v = body.response.docs[idx].latestVersion
			local current_row = vim.api.nvim_win_get_cursor(0)[1]
			local filename = vim.fn.expand("%:t")
			local dependency
			if filename == "pom.xml" then
				dependency = M.maven_dependency(g, a, v)
			else
				dependency = M.gradle_dependency(g, a, v)
			end
			vim.api.nvim_buf_set_lines(0, current_row - 1, current_row, false, dependency)
		end
	end)
end

return M

---@diagnostic disable undefined-global

return {
	s({ trig = "debug", desc = "Debug" }, { t("System.debug('"), i(1), t("')") }),
	s({ trig = "isb", desc = "String isBland" }, { t("String.isBlank('"), i(1), t("')") }),
	s({ trig = "isnb", desc = "String isNotBland" }, { t("String.isNotBlank('"), i(1), t("')") }),
	s(
		{ trig = "method", desc = "method" },
		fmta(
			[[
            <> <> <>(<>) {
                <>
            }
	       ]],
			{ c(1, { t("private"), t("public"), t("global") }), i(2, "void"), i(3), i(4), i(5) }
		)
	),
	s(
		{ trig = "staticmethod", desc = "static method" },
		fmta(
			[[
            <> static <> <>(<>) {
                <>
            }
	       ]],
			{ c(1, { t("private"), t("public"), t("global") }), i(2, "void"), i(3), i(4), i(5) }
		)
	),
}

---@diagnostic disable undefined-global

return {
	s(
		{ trig = "psvm", dscr = "Public static main method" },
		fmta(
			[[
	           public static void main(String[] args) {
	               <>
	           }
	       ]],
			{ i(1) }
		)
	),

	s("retention", t("@Retention(RetentionPolicy.RUNTIME)")),
}

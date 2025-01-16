return {
	{
		"s1n7ax/nvim-window-picker",
		config = function()
			require("window-picker").setup({
				filter_rules = {
					autoselect_one = true,
					include_current_win = true,
				},
				hint = "floating-big-letter",
				selection_chars = "ABCDEF",
			})
		end,
		event = "VeryLazy",
	},
}

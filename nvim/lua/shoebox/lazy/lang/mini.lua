return {
	{
		"echasnovski/mini.nvim",
		config = function()
			require("mini.comment").setup({
				mappings = {
					comment = "<leader>/",
					comment_line = "<leader>/",
					comment_visual = "<leader>/",
					textobject = "<leader>/",
				},
			})

			require("mini.splitjoin").setup({
				mappings = {
					toggle = "st",
					split = "ss",
					join = "sj",
				},
			})

			require("mini.trailspace").setup({})
		end,
	},
}

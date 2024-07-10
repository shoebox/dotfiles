return {
	{
		"echasnovski/mini.nvim",
		event = "VeryLazy",
		config = function()
			require("mini.align").setup({})

			require("mini.comment").setup({
				mappings = {
					comment = "<leader>/",
					comment_line = "<leader>/",
					comment_visual = "<leader>/",
					textobject = "<leader>/",
				},
			})

			local hipatterns = require("mini.hipatterns")
			require("mini.hipatterns").setup({
				highlighters = {
					-- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
					fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
					hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
					todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
					note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },

					-- Highlight hex color strings (`#rrggbb`) using that color
					hex_color = hipatterns.gen_highlighter.hex_color(),
				},
			})

			require("mini.icons").setup({})
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

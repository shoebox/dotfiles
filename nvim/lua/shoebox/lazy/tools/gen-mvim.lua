return {
	{
		"David-Kunz/gen.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"stevearc/dressing.nvim",
		},
		config = function()
			require("gen").setup({
				model = "deepseek-coder:6.7b",
				display_mode = "split",
				no_auto_close = true,
				replace = false,
				show_model = true,
			})

			require("gen").prompts["Advanced code review"] = {
				prompt = "Act as a top-notch Golang developer. Review this code, provide suggestions for improvement, coding best practices (SOLID and DRY), improve readability, and maintainability. \no any code smells and anti-patterns. If the file does not have any code or does not need any changes, say 'No changes needed'. Only ouput the result in format ```$filetype\n...\n```:\n```$filetype\n$text\n```",
				replace = true,
				extract = "```$filetype\n(.-)```",
			}
		end,
		keys = function() end,
		keys = {
			{
				"<leader>]",
				"<cmd>:Gen<CR>",
				desc = "Gen",
			},
		},
	},
}

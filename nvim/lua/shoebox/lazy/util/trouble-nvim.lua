return {
	{
		"folke/trouble.nvim",
		config = function()
			local trouble = require("trouble")

			trouble.setup({
				mode = "document_diagnostics",
				auto_close = true,
				height = 15,
				multiline = true,
				indent_lines = true,
				use_diagnostic_signs = true,
			})
		end,
		keys = {
			{
				"<leader>tt",
				function()
					require("trouble").toggle()
				end,
				desc = "Trouble - Toggle",
			},
		},
	},
}

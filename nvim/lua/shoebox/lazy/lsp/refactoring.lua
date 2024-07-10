return {
	{
		"ThePrimeagen/refactoring.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("refactoring").setup()
		end,
		keys = {
			{
				"<leader>re",
				function()
					require("refactoring").select_refactor()
				end,
				desc = "Refactoring.nvim",
				mode = { "v", "n" },
			},
		},
	},
}

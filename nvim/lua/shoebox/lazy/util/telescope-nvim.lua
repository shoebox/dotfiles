return {
	{
		"nvim-telescope/telescope.nvim",
		config = function()
			require("telescope").setup({
				pickers = {
					find_files = {
						hidden = true,
					},
				},
			})
		end,
		keys = {
			{
				"<leader>p",
				function()
					require("telescope.builtin").live_grep()
				end,
				desc = "Telescope - live grep",
			},
			{
				"<leader>ff",
				function()
					require("telescope.builtin").find_files()
				end,
				desc = "Telescope - Find files",
			},
			{
				"<leader>fg",
				function()
					require("telescope.builtin").git_files()
				end,
				desc = "Telescope - Git files",
			},
			{
				"<C-Q>",
				function()
					require("telescope.builtin").quickfix()
				end,
				desc = "Telescope - quickfix",
			},
		},
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
		},
	},
}

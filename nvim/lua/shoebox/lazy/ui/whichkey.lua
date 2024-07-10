return {
	{
		"folke/which-key.nvim",
		cmd = { "WhichKey" },
		config = function()
			require("which-key").setup({})
		end,
	},
}

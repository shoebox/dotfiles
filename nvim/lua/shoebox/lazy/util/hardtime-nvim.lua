return {
	{
		"m4xshen/hardtime.nvim",
		dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
		cmd = { "Hardtime" },
		config = function()
			require("hardtime").setup({
				disabled_keys = {
					["<Up>"] = {},
					["<Down>"] = {},
					["<Left>"] = {},
					["<Right>"] = {},
				},
			})
		end,
	},
}

return {
	{
		"nvim-lualine/lualine.nvim",
		config = function()
			require("lualine").setup({
				extensions = { "quickfix", "overseer" },
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "filename" },
					lualine_c = { "branch" },
					lualine_d = { "overseer" },
					lualine_x = { "fileformat" },
					lualine_y = { "filetype" },
				},
				options = {
					globalstatus = true,
					theme = "tokyonight",
				},
			})
		end,
		event = "VimEnter",
		dependencies = { "stevearc/overseer.nvim" },
	},
}

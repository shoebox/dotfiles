return {
	{
		"j-hui/fidget.nvim",
		config = function()
			require("fidget").setup({
				notification = {
					-- override_vim_notify = true,
					window = {
						winblend = 0,
					},
				},

				progress = {
					ignore = { "null-ls", "null_ls", "none-ls", "none_ls" },
				},
			})
		end,
	},
}

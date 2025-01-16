return {
	{
		"j-hui/fidget.nvim",
		config = function()
			require("fidget").setup({
				integration = {
					["nvim-tree"] = {
						enable = true, -- Integrate with nvim-tree/nvim-tree.lua (if installed)
					},
				},
				notification = {
					history_size = 24,
					poll_rate = 100,
					override_vim_notify = true,
					view = {
						stack_upwards = false,
					},
					window = {
						normal_hl = "Identifier",
						align = "bottom",
						winblend = 0,
						-- x_padding = 2,
						y_padding = 1,
					},
				},

				progress = {
					ignore_empty_message = true,
					ignore = {},
					display = {
						done_ttl = 1,
						done_style = "comment",
						group_style = "comment",
						progress_style = "comment",
					},
				},
			})
		end,
		event = "VeryLazy",
	},
}

return {
	{
		"nvim-lualine/lualine.nvim",
		config = function()
			require("lualine").setup({
				extensions = {
					"lazy",
					"toggleterm",
					"mason",
					"neo-tree",
					"overseer",
					"quickfix",
					"trouble",
				},
				sections = {
					lualine_a = { { "mode" } },
					lualine_b = { { "branch", icon = "" } },
					lualine_c = {
						{
							"diagnostics",
							symbols = {
								error = "",
								warn = "",
								info = "",
								hint = "󰝶",
							},
						},
						{ "filetype", icon_only = true, separator = "", padding = { left = 0, right = 0 } },
						{ "filename", padding = { left = 1, right = 0 } },
					},
					lualine_x = {},
					lualine_y = {
						{ "progress" },
						{ "location" },
					},
					lualine_z = {
						{
							"datetime",
							style = "  %X",
						},
					},
				},
				options = {
					globalstatus = true,
					component_separators = { left = " ", right = " " },
					section_separators = { left = " ", right = " " },
					theme = "auto",
				},
			})

			vim.cmd([[
                highlight lualine_b_inactive guibg=NONE
                highlight lualine_c_inactive guibg=NONE

                highlight lualine_c_normal guibg=NONE
            ]])
		end,
		event = "VeryLazy",
	},
}

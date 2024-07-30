return {
	{
		"mistweaverco/kulala.nvim",
		config = function()
			vim.filetype.add({
				extension = {
					http = "http",
				},
			})

			-- Setup is required, even if you don't pass any options
			require("kulala").setup()
		end,
		filetype = "http",
		keys = {
			{
				"-r",
				function()
					require("kulala").run()
				end,
				desc = "Kulala run request",
			},
			{
				"-t",
				function()
					require("kulala").toggle_view()
				end,
				desc = "Kulala toggle view",
			},
		},
	},
}

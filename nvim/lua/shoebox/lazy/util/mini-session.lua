return {
	{
		"echasnovski/mini.sessions",
		branch = "stable",
		config = function()
			require("mini.sessions").setup({
				-- Whether to read latest session if Neovim opened without file arguments
				autoread = true,

				-- Whether to write current session before quitting Neovim
				autowrite = true,

                hooks = {

                },
			})
		end,
	},
}

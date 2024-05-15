return {
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-neotest/neotest-go",
			"nvim-treesitter/nvim-treesitter",
			"nvim-neotest/nvim-nio",
		},
		config = function()
			local neotest = require("neotest")
			neotest.setup({
				adapters = {
					require("neotest-go"),
				},
			})
		end,

		keys = {
			{
				"<leader>rtf",
				function()
					require("neotest").run.run()
				end,
				desc = "Neotest - Test function",
			},
			{
				"<leader>rtd",
				function()
					require("neotest").run.run({ strategy = "dap" })
				end,
				desc = "Neotest - Test function",
			},
			{
				"<leader>rtc",
				function()
					require("neotest").run.run(vim.fn.expand("%"))
				end,
				desc = "Neotest - Test class",
			},
			{
				"<leader>rts",
				function()
					require("neotest").summary.toggle()
				end,
				desc = "Neotest - Toggle summary",
			},
		},
	},
}

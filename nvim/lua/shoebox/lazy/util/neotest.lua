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
			-- get neotest namespace (api call creates or returns namespace)
			local neotest_ns = vim.api.nvim_create_namespace("neotest")
			vim.diagnostic.config({
				virtual_text = {
					format = function(diagnostic)
						local message =
							diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
						return message
					end,
				},
			}, neotest_ns)
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
					require("neotest").output_panel.clear()
					require("neotest").run.run()
				end,
				desc = "Neotest - Test function",
			},
			{
				"<leader>rtp",
				function()
					require("neotest").output_panel.toggle()
				end,
				desc = "Neotest - Test function",
			},
			{
				"<leader>rto",
				function()
					require("neotest").output.open()
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

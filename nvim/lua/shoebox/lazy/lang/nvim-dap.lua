return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"rcarriga/nvim-dap-ui",
			{
				"theHamsta/nvim-dap-virtual-text",
                config = function ()
                    require("nvim-dap-virtual-text").setup()
                end
			},
		},
		config = function()
			local function get_arguments()
				local co = coroutine.running()
				if co then
					return coroutine.create(function()
						local args = {}
						vim.ui.input({ prompt = "Args: " }, function(input)
							args = vim.split(input or "", " ")
						end)
						coroutine.resume(co, args)
					end)
				else
					local args = {}
					vim.ui.input({ prompt = "Args: " }, function(input)
						args = vim.split(input or "", " ")
					end)
					return args
				end
			end

			local dap = require("dap")
			dap.adapters.delve = {
				type = "server",
				port = "${port}",
				executable = {
					command = "dlv",
					args = { "dap", "-l", "127.0.0.1:${port}" },
				},
			}

			-- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
			dap.configurations.go = {
				{
					type = "delve",
					name = "Debug",
					request = "launch",
					program = "${file}",
				},
				{
					type = "delve",
					name = "Debug (Arguments)",
					request = "launch",
					program = "${file}",
					args = get_arguments,
				},
				{
					type = "delve",
					name = "Debug test", -- configuration for debugging test files
					request = "launch",
					mode = "test",
					program = "${file}",
				},
				{
					type = "delve",
					name = "Debug test (go.mod)",
					request = "launch",
					mode = "test",
					program = "./${relativeFileDirname}",
				},
			}
			require("dapui").setup()
		end,
		event = "VeryLazy",
	},
}

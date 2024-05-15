return {
	{
		"stevearc/overseer.nvim",
		cmd = { "OverseerRun", "OverseerToggle" },
		config = function()
			require("overseer").setup({
				task_list = {
					default_detail = 2,
					width = 600,
				},
				templates = { "builtin", "user.go_build", "user.nix_build" },
				log = {
					type = "notify",
				},
				-- Aliases for bundles of components. Redefine the builtins, or create your own.
				component_aliases = {
					-- Most tasks are initialized with the default components
					default = {
						{ "display_duration", detail_level = 2 },
						{ "on_result_notify", infer_status_from_diagnostics = true, on_change = false },
						"on_exit_set_status",
					},
					-- Tasks from tasks.json use these components
					default_vscode = {
						"default",
						{ "display_duration", detail_level = 2 },
						"on_output_summarize",
						"on_result_diagnostics",
						"on_result_diagnostics_quickfix",
						"on_complete_notify",
						"on_complete_dispose",
					},
				},
			})
		end,
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
			"rcarriga/nvim-notify",
			"stevearc/dressing.nvim",
		},
		keys = {
			{
				"<leader>ot",
				function()
					require("overseer").toggle()
				end,
				desc = "Overseer - Toggle the running task list",
			},
			{
				"<leader>or",
				"<cmd>OverseerRun",
				desc = "Overseer - Opens the tasks list",
			},
		},
	},
}

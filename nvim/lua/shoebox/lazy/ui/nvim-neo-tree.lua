return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		config = function()
			local git_available = vim.fn.executable("git") == 1

			require("neo-tree").setup({
				close_if_last_window = true,
				auto_clean_after_session_restore = false,
				event_handlers = {

					{
						event = "file_opened",
						handler = function(file_path)
							require("neo-tree.command").execute({ action = "close" })
						end,
					},
				},
				filesystem = {
					follow_current_file = {
						enabled = true,
						leave_dirs_open = false,
					},
					filtered_items = {
						hide_gitignored = git_available,
						never_show = {
							".DS_Store",
							"thumbs.db",
						},
					},
				},
				window = {
					mappings = {
						["<cr>"] = "open_with_window_picker",
						["<c-t>"] = "open_tabnew",
					},
					width = 30,
				},
			})
		end,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
			"s1n7ax/nvim-window-picker",
		},
		keys = {
			{
				"<space>n",
				function()
					vim.cmd("Neotree toggle")
				end,
				desc = "Nvim-tree - toggle",
			},
		},
	},
}

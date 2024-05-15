return {
	{
		"nvim-tree/nvim-tree.lua",
		config = function()
			require("nvim-tree").setup({
				update_focused_file = {
					enable = true,
				},
				view = {
					adaptive_size = false,
				},
				actions = {
					expand_all = {
						exclude = {
							".git",
						},
					},
				},
				filters = {
					custom = { "^.git$" },
				},
			})
		end,
		-- cmd = { "NvimTreeToggle", "NvimTreeFocus", "NvimTreeFindFile", "NvimTreeCollapse" },
		dependencies = { "nvim-tree/nvim-web-devicons" },
		keys = {
			{
				"<space>n",
				function()
					vim.cmd("NvimTreeToggle")
				end,
				desc = "Nvim-tree - toggle",
			},
		},
	},
}

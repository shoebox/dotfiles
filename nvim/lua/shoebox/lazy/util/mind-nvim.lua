return {
	"phaazon/mind.nvim",
	branch = "v2.2",
	cmd = { "MindOpenMain" },
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		require("mind").setup({
			-- edit options
			edit = {
				-- file extension to use when creating a data file
				data_extension = ".adoc",

				-- default header to put in newly created data files
				data_header = "= %s",

				-- format string for copied links
				copy_link_format = "[](%s)",
			},

			-- persistence, both for the tree state and data files
			persistence = {
				-- path where the global mind tree is stored
				state_path = "~/Desktop/mind.nvim/mind.json",

				-- directory where to create global data files
				data_dir = "~/Desktop/mind.nvim/data",
			},
		})
	end,
}

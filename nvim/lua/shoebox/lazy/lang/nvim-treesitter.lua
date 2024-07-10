return {
	{
		"nvim-treesitter/nvim-treesitter",
		config = function()
			require("nvim-treesitter.install").compilers = { "gcc-11" }
			require("nvim-treesitter.configs").setup({
				auto_install = true,
				highlight = {
					enable = true,
				},
			})
			local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
			parser_config.d2 = {
				install_info = {
					url = "https://github.com/pleshevskiy/tree-sitter-d2",
					revision = "main",
					files = { "src/parser.c", "src/scanner.cc" },
				},
				filetype = "d2",
			}
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-refactor",
		config = function()
			require("nvim-treesitter.configs").setup({
				refactor = {
					-- highlight_definitions = {
					-- 	enable = true,
					-- 	-- Set to false if you have an `updatetime` of ~100.
					-- 	clear_on_cursor_move = true,
					-- },

					smart_rename = {
						enable = true,
						-- Assign keymaps to false to disable them, e.g. `smart_rename = false`.
						keymaps = {
							smart_rename = "grr",
						},
					},
					navigation = {
						enable = true,
						goto_definition = "gnd",
						list_definitions = "gnD",
						list_definitions_toc = "gO",
						goto_next_usage = "<a-*>",
						goto_previous_usage = "<a-#>",
					},
				},
			})
		end,
	},
}
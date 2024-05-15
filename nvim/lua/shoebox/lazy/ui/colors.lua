return {
    {
"folke/tokyonight.nvim",
		config = function()
			require("tokyonight").setup({
				dim_inactive = true,
				style = "storm",
				styles = {
					sidebars = "dark",
					floats = "dark",
				},
				terminal_colors = true,
				transparent = true,
			})

			vim.cmd.colorscheme("tokyonight")
		end,
  lazy = false,
  priority = 1000,
  opts = {},
},
{
	"catppuccin/nvim"
},
{
		"loctvl842/monokai-pro.nvim",
		config = function()
			require("monokai-pro").setup()
		end,
	},
}

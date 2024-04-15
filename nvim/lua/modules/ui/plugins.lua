local ui = {}
local p = require("packer")

function ui.packer()
	p.use({
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("ibl").setup({
				enabled = true,
				scope = { enabled = false },
			})
		end,
		event = { "BufRead", "BufNewFile" },
	})

	p.use({
		"m4xshen/smartcolumn.nvim",
		config = function()
			require("smartcolumn").setup({
				colorcolumn = "100",
			})
		end,
	})

	p.use({
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

		cmd = { "NvimTreeToggle", "NvimTreeFocus", "NvimTreeFindFile", "NvimTreeCollapse" },
		requires = { "nvim-tree/nvim-web-devicons" },
	})

	p.use({
		"lewis6991/gitsigns.nvim",
		event = { "BufRead", "BufNewFile" },
		config = function()
			require("gitsigns").setup({})
		end,
		requires = { "nvim-lua/plenary.nvim", opt = true },
	})

	p.use({
		"voldikss/vim-floaterm",
		cmd = { "FloatermToggle", "FloatermNew" },
		setup = function()
			vim.g.floaterm_shell = "zsh"
			vim.g.floaterm_keymap_toggle = "<F7>"
			vim.g.floaterm_width = 0.9
			vim.g.floaterm_height = 0.9
		end,
	})

	p.use({
		"folke/which-key.nvim",
		cmd = { "WhichKey" },
		config = function()
			require("which-key").setup({})
		end,
	})

	p.use({
		"nvim-lualine/lualine.nvim",
		config = function()
			require("lualine").setup({
				extensions = { "quickfix", "overseer" },
				sections = {
					lualine_a = { "mode" },
					lualine_b = {
						"require'lsp-status'.status()",
					},
					lualine_c = { "branch", "filename", "diff" },
					lualine_x = { "fileformat", "filetype" },
					lualine_y = { "overseer", "diff" },
					-- lualine_z = { "location", selected_line },
				},
				options = {
					globalstatus = true,
					theme = "tokyonight",
				},
			})
		end,
		event = "VimEnter",
		requires = { "stevearc/overseer.nvim" },
	})

	p.use({
		"kosayoda/nvim-lightbulb",
		config = function()
			require("nvim-lightbulb").setup({})
		end,
	})

	p.use({
		"loctvl842/monokai-pro.nvim",
		config = function()
			require("monokai-pro").setup()
		end,
	})

	p.use({ "catppuccin/nvim" })

	p.use({
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
	})

	p.use({
		"akinsho/bufferline.nvim",
		config = function()
			require("bufferline").setup({
				options = {
					-- 	always_show_bufferline = true,
					-- 	diagnostics = "nvim_lsp",
					mode = "tabs",
					numbers = "ordinal",
					offsets = {
						{
							filetype = "NvimTree",
							text = "File Explorer",
							text_align = "left",
						},
					},
					separator = false,
					-- separator_style = "slant",
					show_buffer_close_icons = false,
					-- 	show_buffer_icons = false,
					-- 	show_duplicate_prefix = false,
					themable = true,
				},
			})
		end,
	})

	p.use({
		"rcarriga/nvim-notify",
		config = function()
			require("notify").setup({})
		end,
	})
end

return ui

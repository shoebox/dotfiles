local ui = {}
local p = require("packer")

function ui.packer()
	p.use({
		"j-hui/fidget.nvim",
		config = function()
			require("fidget").setup({
				notification = {
					-- override_vim_notify = true,
					window = {
						winblend = 0,
					},
				},

				progress = {
					ignore = { "null-ls", "null_ls", "none-ls", "none_ls" },
				},

				integration = {
					["nvim-tree"] = {
						enable = true,
					},
				},
			})
		end,
	})

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
		setup = function()
			local opts = { noremap = true, silent = true }
			vim.keymap.set("n", "<space>n", function()
				vim.cmd("NvimTreeToggle")
			end, opts)
		end,
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

			local opts = { noremap = true, silent = true }
			vim.keymap.set("n", "<F7>", function()
				vim.cmd("FloatermToggle")
			end, opts)

			vim.keymap.set("t", "<F7>", function()
				vim.cmd("<C-\\><C-n>:FloatermToggle")
			end, opts)
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
					lualine_b = { "filename" },
					lualine_c = { "branch" },
					lualine_d = { "overseer" },
					lualine_x = { "fileformat" },
					lualine_y = { "filetype" },
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
					show_buffer_close_icons = false,
					show_buffer_icons = false,
					show_duplicate_prefix = false,
					themable = true,
				},
			})
		end,
		setup = function()
			local opts = { noremap = true, silent = true }
			vim.keymap.set("n", "<space>1", function()
				vim.cmd("BufferLineGoToBuffer 1")
			end, opts)
			vim.keymap.set("n", "<space>2", function()
				vim.cmd("BufferLineGoToBuffer 2")
			end, opts)
			vim.keymap.set("n", "<space>3", function()
				vim.cmd("BufferLineGoToBuffer 3")
			end, opts)
			vim.keymap.set("n", "<space>4", function()
				vim.cmd("BufferLineGoToBuffer 4")
			end, opts)
			vim.keymap.set("n", "<space>5", function()
				vim.cmd("BufferLineGoToBuffer 5")
			end, opts)
			vim.keymap.set("n", "<space>6", function()
				vim.cmd("BufferLineGoToBuffer 6")
			end, opts)
			vim.keymap.set("n", "<space>7", function()
				vim.cmd("BufferLineGoToBuffer 7")
			end, opts)
			vim.keymap.set("n", "<space>8", function()
				vim.cmd("BufferLineGoToBuffer 8")
			end, opts)
			vim.keymap.set("n", "<space>9", function()
				vim.cmd("BufferLineGoToBuffer 9")
			end, opts)
		end,
	})

	p.use({
		"rcarriga/nvim-notify",
		config = function()
			require("notify").setup({})
		end,
	})

	p.use({
		"folke/zen-mode.nvim",
		cmd = "ZenMode",
		config = function()
			vim.keymap.set("n", "<leader>zz", function()
				require("zen-mode").setup({
					window = {
						width = 100,
						options = {},
					},
				})
				require("zen-mode").toggle()
			end)
		end,
	})
end

return ui

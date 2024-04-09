local ui = {}
local conf = require("modules.ui.config")
local p = require("packer")

function ui.packer()
	local cfgui = require("modules.ui.config")
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
		end,
	})

	p.use({ "folke/which-key.nvim", cmd = { "WhichKey" }, config = cfgui.whichkey })

	p.use({
		"nvim-lualine/lualine.nvim",
		config = cfgui.lualine,
		event = "VimEnter",
		requires = { "stevearc/overseer.nvim" },
	})

	p.use({
		"kosayoda/nvim-lightbulb",
		config = cfgui.lightbulb,
	})

    p.use({
        "loctvl842/monokai-pro.nvim",
        config = function()
            require("monokai-pro").setup()
        end
    })

	p.use({ "catppuccin/nvim" })
	p.use({ "folke/tokyonight.nvim" })
	p.use({
		"akinsho/bufferline.nvim",
		config = cfgui.bufferline_nvim,
	})
	p.use({
		"rcarriga/nvim-notify",
		config = function()
			require("notify").setup({})
		end,
	})
	p.use({
		"HampusHauffman/block.nvim",
		config = function()
			require("block").setup({
				percent = 1.1,
				depth = 6,
			})
		end,
		cmd = { "BlockOn", "BlockOff", "Block" },
	})

	-- p.use({
	-- 	"folke/noice.nvim",
	-- 	event = "VimEnter",
	-- })
end

return ui

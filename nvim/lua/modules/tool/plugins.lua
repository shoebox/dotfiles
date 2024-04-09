local tools = {}
local p = require("packer")

function tools.packer()
    p.use({
        "ThePrimeagen/refactoring.nvim",
        requires = {
            {"nvim-lua/plenary.nvim"},
            {"nvim-treesitter/nvim-treesitter"}
        },
        config = function()
            require("refactoring").setup()
        end,
    })

	p.use({ "nvim-lua/plenary.nvim" })

	p.use({
	    "David-Kunz/gen.nvim",
	    cmd = { "Gen" },
		requires = {
			"nvim-lua/plenary.nvim",
			"stevearc/dressing.nvim",
		},
		config = function()
		    require("gen").setup({
		        model = "mistral",
		        display_mode = "split",
		        no_auto_close = true,
		        replace = false,
		        show_model = true,
		    })
		end,
	})

	p.use({
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		config = function()
			require("telescope").setup({
				pickers = {
					find_files = {
						hidden = true,
					},
				},
			})
		end,
		setup = function()
			if not packer_plugins["plenary.nvim"].loaded then
				require("packer").loader("plenary.nvim")
			end
		end,
		requires = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope-fzy-native.nvim", opt = true },
			{ "nvim-telescope/telescope-fzf-native.nvim", run = "make", opt = true },
			{ "nvim-telescope/telescope-live-grep-raw.nvim", opt = true },
			{ "nvim-telescope/telescope-file-browser.nvim", opt = true },
		},
	})
	p.use({
		"echasnovski/mini.sessions",
		branch = "stable",
		config = function()
			require("mini.sessions").setup({
				-- Whether to read latest session if Neovim opened without file arguments
				autoread = true,

				-- Whether to write current session before quitting Neovim
				autowrite = true,
			})
		end,
	})

	p.use({
		"tpope/vim-fugitive",
		cmd = { "G", "Git", "GCommit", "Gpull", "Gpush" },
	})

	p.use({
		"folke/trouble.nvim",
		-- cmd = { "Trouble", "TroubleToggle" },
		config = function()
			require("trouble").setup({
				mode = "document_diagnostics",
				-- auto_open = true,
				auto_close = true,
				height = 15,
				multiline = true,
				indent_lines = true,
				use_diagnostic_signs = true,
			})
		end,
	})

	-- p.use({
	-- 	"pwntester/octo.nvim",
	-- 	cmd = { "Octo" },
	-- 	requires = {
	-- 		"nvim-lua/plenary.nvim",
	-- 		"nvim-telescope/telescope.nvim",
	-- 		"kyazdani42/nvim-web-devicons",
	-- 	},
	-- 	config = function()
	-- 		require("octo").setup()
	-- 	end,
	-- })
	--
	p.use({
		"sindrets/diffview.nvim",
		requires = "nvim-lua/plenary.nvim",
		cmd = { "DiffviewFileHistory", "DiffviewOpen" },
	})

	p.use({
		"phaazon/hop.nvim",
		branch = "v2",
		config = function()
			require("hop").setup()
		end,
	})

	p.use({
		"akinsho/toggleterm.nvim",
		config = function()
			require("toggleterm").setup({
				size = 20,
			})
		end,
		cmd = { "ToggleTerm" },
	})

	p.use({
		"stevearc/overseer.nvim",
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
		cmd = { "OverseerRun", "OverseerToggle" },
	})

	p.use({
		"Wansmer/treesj",
		requires = { "nvim-treesitter" },
		config = function()
			require("treesj").setup({
			    keys = { '<space>m', '<space>j', '<space>s' },
			})

            local opts = { noremap=true, silent=true }
            vim.keymap.set("n", "<leader>zt", function() require('treesj').toggle() end, opts)
            vim.keymap.set("n", "<leader>zs", function() require('treesj').split() end, opts)
            vim.keymap.set("n", "<leader>zj", function() require('treesj').join() end, opts)
		end,
	})

	p.use({
		"phaazon/mind.nvim",
		branch = "v2.2",
		cmd = { "MindOpenMain" },
		requires = { "nvim-lua/plenary.nvim" },
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
	})

	p.use({
		"kdheepak/lazygit.nvim",
		cmd = "LazyGit",
        config = function()
        end,
	})

	p.use({
		"junegunn/vim-easy-align",
		config = function() end,
	})
end

return tools

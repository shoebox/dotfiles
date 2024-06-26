local tools = {}
local p = require("packer")

function tools.packer()
	p.use({
		"ThePrimeagen/refactoring.nvim",
		requires = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-treesitter/nvim-treesitter" },
		},
		config = function()
			require("refactoring").setup()
		end,
		setup = function()
			vim.keymap.set("x", "<leader>re", function()
				require("refactoring").refactor("Extract Function")
			end)
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
				model = "deepseek-coder:6.7b",
				display_mode = "split",
				no_auto_close = true,
				replace = false,
				show_model = true,
			})

			require("gen").prompts["Advanced code review"] = {
				prompt = "Act as a top-notch Golang developer. Review this code, provide suggestions for improvement, coding best practices (SOLID and DRY), improve readability, and maintainability. \no any code smells and anti-patterns. If the file does not have any code or does not need any changes, say 'No changes needed'. Only ouput the result in format ```$filetype\n...\n```:\n```$filetype\n$text\n```",
				replace = true,
				extract = "```$filetype\n(.-)```",
			}
		end,
		setup = function()
			vim.keymap.set({ "n", "v" }, "<leader>]", ":Gen<CR>")
		end,
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
		config = function()
			local trouble = require("trouble")

			trouble.setup({
				mode = "document_diagnostics",
				auto_close = true,
				height = 15,
				multiline = true,
				indent_lines = true,
				use_diagnostic_signs = true,
			})

			vim.keymap.set("n", "<leader>tt", function()
				trouble.toggle()
			end)
		end,
	})

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
		"Wansmer/treesj",
		requires = { "nvim-treesitter" },
		config = function()
			require("treesj").setup({
				keys = { "<space>m", "<space>j", "<space>s" },
			})

			local opts = { noremap = true, silent = true }
			vim.keymap.set("n", "<leader>zt", function()
				require("treesj").toggle()
			end, opts)
			vim.keymap.set("n", "<leader>zs", function()
				require("treesj").split()
			end, opts)
			vim.keymap.set("n", "<leader>zj", function()
				require("treesj").join()
			end, opts)
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
		setup = function()
			vim.keymap.set("n", "<leader>gg", ":LazyGit<CR>")
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
		requires = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope-fzy-native.nvim", opt = true },
			{ "nvim-telescope/telescope-fzf-native.nvim", run = "make", opt = true },
			{ "nvim-telescope/telescope-live-grep-raw.nvim", opt = true },
			{ "nvim-telescope/telescope-file-browser.nvim", opt = true },
		},
		setup = function()
			local opts = { noremap = true, silent = true }
			vim.keymap.set("n", "<leader>p", function()
				vim.cmd("Telescope live_grep")
			end, opts)

			vim.keymap.set("n", "<leader>fb", function()
				vim.cmd("Telescope file_browser")
			end, opts)

			vim.keymap.set("n", "<leader>ff", function()
				vim.cmd("Telescope find_files")
			end, opts)

			vim.keymap.set("n", "<leader>fg", function()
				vim.cmd("Telescope git_files")
			end, opts)

			vim.keymap.set("n", "<C-Q>", function()
				require("telescope.builtin").quickfix()
			end, opts)

			if not packer_plugins["plenary.nvim"].loaded then
				require("packer").loader("plenary.nvim")
			end
		end,
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
		config = function()
			local trouble = require("trouble")

			trouble.setup({
				mode = "document_diagnostics",
				auto_close = true,
				height = 15,
				multiline = true,
				indent_lines = true,
				use_diagnostic_signs = true,
			})

			vim.keymap.set("n", "<leader>tt", function()
				trouble.toggle()
			end)
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
		setup = function()
			local opts = { noremap = true, silent = true }
			vim.keymap.set("n", "<leader>or", function()
				vim.cmd("OverseerRun")
			end, opts)

			vim.keymap.set("n", "<leader>ot", function()
				vim.cmd("OverseerToggle bottom")
			end, opts)
		end,
	})

	p.use({
		"Wansmer/treesj",
		requires = { "nvim-treesitter" },
		config = function()
			require("treesj").setup({
				keys = { "<space>m", "<space>j", "<space>s" },
			})

			local opts = { noremap = true, silent = true }
			vim.keymap.set("n", "<leader>zt", function()
				require("treesj").toggle()
			end, opts)
			vim.keymap.set("n", "<leader>zs", function()
				require("treesj").split()
			end, opts)
			vim.keymap.set("n", "<leader>zj", function()
				require("treesj").join()
			end, opts)
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
		config = function() end,
	})

	p.use({
		"junegunn/vim-easy-align",
		config = function() end,
	})

	p.use({
		"junegunn/vim-easy-align",
		config = function() end,
	})
end

return tools

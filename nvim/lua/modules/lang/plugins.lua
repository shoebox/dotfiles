local lang = {}
local p = require("packer")

function lang.packer()
	p.use({
		"vim-scripts/haproxy",
		filetype = "haproxy",
	})

	p.use({
		"mfussenegger/nvim-dap",
		requires = { "nvim-neotest/nvim-nio", "rcarriga/nvim-dap-ui" },
		config = function()
			local function get_arguments()
				local co = coroutine.running()
				if co then
					return coroutine.create(function()
						local args = {}
						vim.ui.input({ prompt = "Args: " }, function(input)
							args = vim.split(input or "", " ")
						end)
						coroutine.resume(co, args)
					end)
				else
					local args = {}
					vim.ui.input({ prompt = "Args: " }, function(input)
						args = vim.split(input or "", " ")
					end)
					return args
				end
			end

			local dap = require("dap")
			dap.adapters.delve = {
				type = "server",
				port = "${port}",
				executable = {
					command = "dlv",
					args = { "dap", "-l", "127.0.0.1:${port}" },
				},
			}

			-- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
			dap.configurations.go = {
				{
					type = "delve",
					name = "Debug",
					request = "launch",
					program = "${file}",
				},
				{
					type = "delve",
					name = "Debug (Arguments)",
					request = "launch",
					program = "${file}",
					args = get_arguments,
				},
				{
					type = "delve",
					name = "Debug test", -- configuration for debugging test files
					request = "launch",
					mode = "test",
					program = "${file}",
				},
				{
					type = "delve",
					name = "Debug test (go.mod)",
					request = "launch",
					mode = "test",
					program = "./${relativeFileDirname}",
				},
			}
			require("dapui").setup()
		end,
	})

	p.use({
		"LnL7/vim-nix",
		ft = "nix",
	})

	p.use({
		"echasnovski/mini.nvim",
		config = function()
			require("mini.comment").setup({
				mappings = {
					comment = "<leader>/",
					comment_line = "<leader>/",
					comment_visual = "<leader>/",
					textobject = "<leader>/",
				},
			})

			require("mini.splitjoin").setup({
				mappings = {
					toggle = "st",
					split = "ss",
					join = "sj",
				},
			})

			require("mini.trailspace").setup({})
		end,
	})

	p.use({
		"ray-x/go.nvim",
		requires = {
			"neovim/nvim-lspconfig",
			"nvim-treesitter/nvim-treesitter",
			"ray-x/guihua.lua",
		},
		config = function()
			require("go").setup({
				trouble = true,
				-- lsp_gofumpt = true,
				-- lsp_diag_update_in_insert = true,
				-- lsp_document_formatting = true,
				diagnostic = {
					virtual_text = { prefix = "🐹" },
					-- signs = true,
					-- update_in_insert = false,
				},
			})
		end,
		ft = { "go", "gomod" },
	})

	p.use({
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
	})

	p.use({
		"nvim-neotest/neotest",
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-neotest/neotest-go",
			"nvim-treesitter/nvim-treesitter",
			"nvim-neotest/nvim-nio",
		},
		config = function()
			local neotest = require("neotest")
			neotest.setup({
				adapters = {
					require("neotest-go"),
				},
			})

			vim.keymap.set("", "<leader>rtf", function()
				neotest.run.run()
			end, { remap = false })

			vim.keymap.set("", "<leader>rtd", function()
				neotest.run.run({ strategy = "dap" })
			end, { remap = false })

			vim.keymap.set("", "<leader>rts", function()
				neotest.summary.toggle()
			end, { remap = false })

			vim.keymap.set("", "<leader>rtc", function()
				neotest.run.run(vim.fn.expand("%"))
			end, { remap = false })
		end,
	})

	p.use({
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
	})

	p.use({
		"terrastruct/d2-vim",
		ft = { "d2" },
	})
end

return lang

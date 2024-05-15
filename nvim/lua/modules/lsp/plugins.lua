local lsp = {}

local p = require("packer")

function lsp.packer()
	p.use({ "mfussenegger/nvim-ansible" })

	p.use({
		"ray-x/lsp_signature.nvim",
		config = function()
			require("lsp_signature").setup({
				auto_close_after = 200,
				bind = true,
				close_timeout = 200,
				doc_lines = 20,
				noice = true,
				transparency = 10,
				wrap = true,
			})
		end,
	})

	p.use({ "nvim-lua/lsp-status.nvim" })

	p.use({
		"neovim/nvim-lspconfig",
		requires = {
			"williamboman/mason-lspconfig.nvim",
			"williamboman/mason.nvim",
			"williamboman/mason.nvim",
		},
		after = {
			"lsp_signature.nvim",
		},
		event = "BufReadPre",
		config = function()
			require("mason").setup({})
			require("mason-lspconfig").setup({
				ensure_installed = {
					"gopls",
				},
				handlers = {
					function(server_name) -- default handler (optional)
						local server = require("lspconfig")[server_name]
						server.setup({
							capabilities = capabilities,
							on_attach = function(client, bufnr)
								require("lsp_signature").on_attach(require("lsp_signature"), bufnr)
							end,
						})
					end,
				},
			})

			vim.diagnostic.config({
				update_in_insert = true,
				float = {
					focusable = false,
					style = "minimal",
					border = "rounded",
					source = "always",
					header = "",
					prefix = "",
				},
			})
		end,
		setup = function()
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					local opts = { buffer = ev.buf }

					vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
					vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
					vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
					vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
					vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)

					-- formatting
					vim.keymap.set("n", "<leader>f", function()
						vim.lsp.buf.format({ async = true })
					end, opts)

					-- code actions
					vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

					-- workspace
					vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
					vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
					vim.keymap.set("n", "<space>wl", function()
						print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
					end, opts)

					-- diagnostics
					vim.keymap.set("n", "<leader>dl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
					vim.keymap.set("n", "<leader>dn", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
					vim.keymap.set("n", "<leader>dp", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
					vim.keymap.set("n", "<leader>dh", "<cmd>lua vim.diagnostic.hide()<CR>", opts)
					vim.keymap.set("n", "<leader>ds", "<cmd>lua vim.diagnostic.show()<CR>", opts)
				end,
			})
		end,
	})

	p.use({
		"nvimtools/none-ls.nvim",
		config = function()
			local null_ls = require("null-ls")

			null_ls.setup({
				sources = {
					null_ls.builtins.completion.spell,

					-- code actions
					null_ls.builtins.code_actions.impl,
					null_ls.builtins.code_actions.refactoring,
					null_ls.builtins.code_actions.statix,

					-- diagnostics
					null_ls.builtins.diagnostics.ansiblelint,
					null_ls.builtins.diagnostics.commitlint,
					null_ls.builtins.diagnostics.deadnix,
					null_ls.builtins.diagnostics.golangci_lint,
					null_ls.builtins.diagnostics.hadolint,
					null_ls.builtins.diagnostics.sqlfluff.with({
						extra_args = { "--dialect", "postgres" }, -- change to your dialects
					}),
					null_ls.builtins.diagnostics.statix,
					null_ls.builtins.diagnostics.vale,
					null_ls.builtins.diagnostics.yamllint,
					null_ls.builtins.diagnostics.zsh,

					-- Formatting
					-- Formatting/nix
					null_ls.builtins.formatting.alejandra,
					null_ls.builtins.formatting.nixfmt,
					null_ls.builtins.formatting.nixpkgs_fmt,
					-- Formatting/golang
					null_ls.builtins.formatting.gofmt,
					null_ls.builtins.formatting.gofumpt,
					null_ls.builtins.formatting.goimports,
					null_ls.builtins.formatting.goimports_reviser,
					null_ls.builtins.formatting.golines,
					-- Formatting/lua
					null_ls.builtins.formatting.prettierd,
					null_ls.builtins.formatting.stylua,
					-- Formatting/sql
					null_ls.builtins.formatting.sqlfluff.with({
						extra_args = { "--dialect", "postgres" }, -- change to your dialects
					}),
					null_ls.builtins.formatting.pg_format,
				},
				on_attach = function(client, bufnr)
					if client.supports_method("textDocument/formatting") then
						vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
						vim.api.nvim_create_autocmd({ "BufWritePre", "InsertLeave" }, {
							group = augroup,
							buffer = bufnr,
							callback = function()
								vim.lsp.buf.format({ async = false })
							end,
						})
					end
				end,
			})
		end,
	})

	p.use({
		"hrsh7th/nvim-cmp",
		config = function()
			local cmp = require("cmp")
			local sources = {}
			cmp.setup({
				completion = {
					autocomplete = { require("cmp.types").cmp.TriggerEvent.TextChanged },
					completeopt = "menu,menuone,noselect",
				},
				formatting = {
					format = function(entry, vim_item)
						vim_item.menu = ({
							buffer = " ﬘",
							nvim_lsp = " ",
							luasnip = " 🐍",
							treesitter = " ",
							nvim_lua = " ",
							spell = " 暈",
							emoji = "ﲃ",
							look = "﬜",
						})[entry.source.name]
						return vim_item
					end,
				},
				mapping = {
					["<up>"] = cmp.mapping.select_prev_item(),
					["<down>"] = cmp.mapping.select_next_item(),
					["<CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
				},
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				sources = {
					{ name = "nvim_lsp" },
					-- { name = "buffer" },
					{ name = "path" },
					-- { name = "cmdline" },
					-- { name = "emoji" },
				},
			})
		end,
		requires = {
			"L3MON4D3/LuaSnip",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-emoji",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
			"neovim/nvim-lspconfig",
		},
	})
end
return lsp

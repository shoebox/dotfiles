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
		event = "BufReadPre",
		config = function()
			local servers = {
				-- "ansiblels",
				"bashls",
				"cucumber_language_server",
				"gopls",
				"rnix",
				"terraform_lsp",
				"terraformls",
				"tsserver",
				"yamlls",
			}

			local lspcfg = require("lspconfig")
			local sign = require("lsp_signature")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			for _, def in pairs(servers) do
				local cfg = lspcfg[def]
				cfg.setup({
					capabilities = capabilities,
				})

				sign.setup(cfg)
			end
		end,
		requires = {
			"hrsh7th/cmp-nvim-lsp",
		},
		after = {
			"lsp_signature.nvim",
		},
	})

	p.use({
		"nvimtools/none-ls.nvim",
		config = function()
			local null_ls = require("null-ls")

			null_ls.setup({
				sources = {
					null_ls.builtins.completion.spell,

					-- diagnostics
					null_ls.builtins.diagnostics.ansiblelint,
					null_ls.builtins.diagnostics.commitlint,
					null_ls.builtins.diagnostics.deadnix,
					null_ls.builtins.diagnostics.golangci_lint,
					null_ls.builtins.diagnostics.hadolint,
					null_ls.builtins.diagnostics.statix,
					null_ls.builtins.diagnostics.vale,
					null_ls.builtins.diagnostics.yamllint,
					null_ls.builtins.diagnostics.zsh,

					-- Formatting
					null_ls.builtins.formatting.alejandra,
					null_ls.builtins.formatting.nixfmt,
					null_ls.builtins.formatting.nixpkgs_fmt,
					null_ls.builtins.formatting.prettier,
					null_ls.builtins.formatting.stylua,
				},
			})
		end,
	})

	p.use({
		"hrsh7th/nvim-cmp",
		config = function()
			local cmp = require("cmp")
			local sources = {
				{ name = "nvim_lsp" },
				{ name = "treesitter", keyword_length = 2 },
				{ name = "look", keyword_length = 2 },
				{ name = "path" },
			}
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
				sources = sources,
			})
		end,
		requires = {
			"neovim/nvim-lspconfig",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-emoji",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"L3MON4D3/LuaSnip",
		},
	})
end
return lsp

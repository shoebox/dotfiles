return {
	{
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
		dependencies = {
			"L3MON4D3/LuaSnip",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-emoji",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
			"neovim/nvim-lspconfig",
		},
	},
}

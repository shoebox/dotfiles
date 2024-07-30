return {
	{
		"hrsh7th/nvim-cmp",
		config = function()
			local icons = require("mini.icons")
			local cmp = require("cmp")
			cmp.setup({
				completion = {
					autocomplete = { require("cmp.types").cmp.TriggerEvent.TextChanged },
					completeopt = "menu,menuone,noselect",
				},
				formatting = {
					format = function(entry, vim_item)
						vim_item.kind = string.format("%s %s", icons.get("lsp", vim_item.kind:lower()), vim_item.kind)

						vim_item.menu = ({
							buffer = "[Buffer]",
							nvim_lsp = "",
							luasnip = "[LuaSnip]",
							nvim_lua = "[Lua]",
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
					{ name = "buffer" },
					{ name = "luasnip" },
					{ name = "path" },
					{ name = "buffer" },
				},
			})
		end,
		dependencies = {
			"echasnovski/mini.nvim",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-emoji",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
			"neovim/nvim-lspconfig",
			"rafamadriz/friendly-snippets",
			{
				"windwp/nvim-autopairs",
				event = "InsertEnter",
				module = true,
				config = function()
					require("nvim-autopairs").setup({})
				end,
			},
			{
				"f3fora/cmp-spell",
				lazy = true,
				ft = { "asciidoc", "markdown" },
			},
			{
				"hrsh7th/cmp-emoji",
				lazy = true,
				ft = { "asciidoc", "markdown" },
			},
		},
		event = { "InsertEnter", "CmdlineEnter" },
	},
}

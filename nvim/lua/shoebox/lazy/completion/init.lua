local vim = vim
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
					col_offset = -3,
					side_padding = 0,
				},
				formatting = {
					fields = { "kind", "abbr", "menu" },
					format = function(entry, vim_item)
						local kind = require("lspkind").cmp_format({
							mode = "symbol_text",
							maxwidth = 100,
						})(entry, vim_item)

						local strings = vim.split(kind.kind, "%s", { trimempty = true })

						kind.kind = " " .. (strings[1] or "") .. " "
						kind.menu = "    (" .. (strings[2] or "") .. ")"

						local colorize = function(group, hl, revert)
							revert = revert or true
							local fn = vim.fn
							local bg = fn.synIDattr(fn.synIDtrans(fn.hlID(hl)), "bg#")
							local fg = fn.synIDattr(fn.synIDtrans(fn.hlID(hl)), "fg#")

							vim.api.nvim_set_hl(0, group, {
								fg = revert and bg or fg,
								bg = revert and fg or bg,
							})
						end

						colorize("CmpItemKindField", "@variable.member")
						colorize("CmpItemKindProperty", "@property")
						colorize("CmpItemKindEvent", "@constant")

						colorize("CmpItemKindText", "@property")
						colorize("CmpItemKindEnum", "@variable.member")
						colorize("CmpItemKindKeyword", "@keyword")

						colorize("CmpItemKindConstant", "@constant")
						colorize("CmpItemKindConstructor", "@type")
						colorize("CmpItemKindReference", "@variable.parameter.reference")

						colorize("CmpItemKindFunction", "@function")
						colorize("CmpItemKindStruct", "@constant")
						colorize("CmpItemKindClass", "@type")
						colorize("CmpItemKindModule", "@module")
						colorize("CmpItemKindOperator", "@operator")

						colorize("CmpItemKindVariable", "@variable")
						colorize("CmpItemKindFile", "@variable")

						colorize("CmpItemKindUnit", "@constant")
						colorize("CmpItemKindSnippet", "@constant")
						colorize("CmpItemKindFolder", "@constant")

						colorize("CmpItemKindMethod", "@function.method")
						colorize("CmpItemKindEnumMember", "@variable.member")
						colorize("CmpItemKindValue", "@variable.member")

						colorize("CmpItemKindInterface", "@type")
						colorize("CmpItemKindColor", "DevIconCss")
						colorize("CmpItemKindTypeParameter", "@variable.parameter")

						colorize("CmpItemKindSnippet", "@constant")

						colorize("CmpItemKindFile", "TSURI")

						return kind
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
				window = {
					completion = {
						col_offset = 0,
						side_padding = 0,
					},
				},
			})
		end,
		dependencies = {
			"echasnovski/mini.nvim",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
			"neovim/nvim-lspconfig",
			{ "onsails/lspkind.nvim", lazy = true },
			{ "rafamadriz/friendly-snippets", lazy = true },
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
		},
		event = { "InsertEnter", "CmdlineEnter" },
	},
}

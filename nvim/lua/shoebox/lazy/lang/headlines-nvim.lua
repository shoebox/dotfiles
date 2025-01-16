return {
	{
		"lukas-reineke/headlines.nvim",
		dependencies = "nvim-treesitter/nvim-treesitter",
		config = function()
			require("headlines").setup({
				markdown = {},
				loongdoc = {
					query = vim.treesitter.query.parse(
						"loongdoc",
						[[
                            [
					            (title_h0_marker)
					            (title_h1_marker)
					            (title_h2_marker)
					            (title_h3_marker)
                            ] @headline

                            [ (quoted_line) ] @quote
                        ]]
					),
					headline_highlights = { "Headline" },
					bullet_highlights = {
						"@loongdoc.title.h0.marker",
						"@loongdoc.title.h1.marker",
						"@loongdoc.title.h2.marker",
						"@loongdoc.title.h3.marker",
						"@loongdoc.title.h4.marker",
					},
					bullets = { "◉", "○", "✸", "✿" },
					codeblock_highlight = "quotes_block",
					dash_highlight = "Dash",
					dash_string = "-",
					doubledash_highlight = "DoubleDash",
					doubledash_string = "=",
					uote_highlight = "Quote",
					quote_string = "quoted_line",
					fat_headlines = true,
					fat_headline_upper_string = "▃",
					fat_headline_lower_string = "🬂",
				},
			})
		end,
		event = "VeryLazy",
		ft = { "asciidoc", "adoc", "loongdoc" },
	},
}

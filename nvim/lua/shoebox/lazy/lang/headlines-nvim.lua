return {
  {
    "lukas-reineke/headlines.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "cathaysia/tree-sitter-asciidoc",
    },
    config = function()
      require("headlines").setup({
        asciidoc = {
          query = vim.treesitter.query.parse(
            "asciidoc",
            [[
                [
                    (title_h0_marker)
                    (title_h1_marker)
                    (title_h2_marker)
                    (title_h3_marker)
                    (title_h4_marker)
                    (title_h5_marker)
                ] @headline
            ]]
          ),
          headline_highlights = { "headline" },
          bullet_highlights = { "Demo" },
          bullets = { "◉", "○", "✸", "✿" },
          dash_string = "*",
          quote_highlight = "Quote",
          quote_string = "┃ ",
          fat_headlines = false,
          fat_headline_upper_string = "▄",
          fat_headline_lower_string = "▀",
        },
      })
    end,
    ft = { "asciidoc", "adoc", "loongdoc" },
  },
}

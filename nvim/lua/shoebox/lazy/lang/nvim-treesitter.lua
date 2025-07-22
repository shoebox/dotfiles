return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        auto_install = true,
        ensure_installed = {
          "asciidoc",
          "go",
        },
        highlight = {
          enable = true,
          custom_captures = { todo = "Todo" },
          use_languagetree = true,
        },
        indent = { enable = true },
        incremental_selection = {
          enable = false,
          keymaps = {
            init_selection = "<C-space>",
            node_incremental = "<C-space>",
            scope_incremental = false,
            node_decremental = "<bs>",
          },
        },
      })
    end,
    event = { "BufReadPre", "BufNewFile" },
  },
  {
    "cathaysia/tree-sitter-asciidoc",
    after = "nvim-treesitter/nvim-treesitter",
    config = function()
      local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
      parser_config.asciidoc = {
        install_info = {
          url = "https://github.com/cathaysia/tree-sitter-asciidoc.git",
          files = { "tree-sitter-asciidoc/src/parser.c", "tree-sitter-asciidoc/src/scanner.c" },
          branch = "master",
          generate_requires_npm = false,
          requires_generate_from_grammar = false,
        },
      }
      parser_config.asciidoc_inline = {
        install_info = {
          url = "https://github.com/cathaysia/tree-sitter-asciidoc.git",
          files = {
            "tree-sitter-asciidoc_inline/src/parser.c",
            "tree-sitter-asciidoc_inline/src/scanner.c",
          },
          branch = "master",
          generate_requires_npm = false,
          requires_generate_from_grammar = false,
        },
      }
    end,
    setup = function()
      vim.filetype.add({
        extension = {
          adoc = "asciidoc",
        },
      })
    end,
    ft = { "asciidoc", "asciidoc", "adoc" },
  },
}

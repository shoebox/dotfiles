return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "asciidoc" },
        auto_install = true,
        highlight = {
          enable = true,
        },
        indent = { enable = true },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<C-space>",
            node_incremental = "<C-space>",
            scope_incremental = false,
            node_decremental = "<bs>",
          },
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
    event = { "BufReadPre", "BufNewFile" },
  },
  {
    "cathaysia/tree-sitter-asciidoc",
    after = "nvim-treesitter/nvim-treesitter",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "asciidoc" }, -- Ensure the Asciidoc parser is installed
      })

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

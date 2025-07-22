local vim = vim or {}

return {
  {
    "stevearc/conform.nvim",
    setup = function()
      print("Setting up conform.nvim")
      vim.diagnostic.config({ virtual_lines = { current_line = true } })
    end,
    config = function()
      local conform = require("conform")
      conform.formatters.yamlfmt = {
        prepend_args = {
          "-formatter",
          "retain_line_breaks=true",
          "include_document_start=true",
        },
      }

      conform.setup({
        format_on_save = {
          timeout_ms = 500,
          lsp_format = "fallback",
        },
        formatters_by_ft = {
          ["yaml"] = { "yamlfmt" },
          ["go"] = { "gofumpt", "goimports-reviser", "golines" },
          ["nix"] = { "alejandra", "nixfmt", "nixpkgs_fmt" },
          ["lua"] = { "stylua", "prettierd" },
          ["toml"] = { "taplo" },
          ["tf"] = {
            "terraform_fmt",
            formatters = {
              dprint = {
                condition = function(_, ctx)
                  return vim.fs.find({ "dprint.json" }, { path = ctx.filename, upward = true })[1]
                end,
              },
            },
          },
        },
      })
    end,
    event = "VimEnter",
  },
}

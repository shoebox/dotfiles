return {
  {
    "stevearc/conform.nvim",
    event = "VimEnter",
    opts = {
      format_on_save = {
        timeout_ms = 500,
        lsp_format = "fallback",
      },
      formatters_by_ft = {
        ["go"] = { "gofumpt", "goimports-reviser", "golines" },
        ["nix"] = { "alejandra", "nixfmt", "nixpkgs_fmt" },
        ["lua"] = { "stylua", "prettierd" },
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
    },
  },
}

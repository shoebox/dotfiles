local vim = vim or {}

return {
  {
    "mfussenegger/nvim-lint",
    event = { "BufWritePost", "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require("lint")
      lint.linters_by_ft = {
        ansible = { "ansible_lint" },
        dockerfile = { "hadolint" },
        go = { "golangcilint" },
        lua = { "luacheck" },
        nix = { "deadnix" },
        yaml = { "yamllint" },
      }
      lint.linters_by_ft["yaml.githubworkflow"] = { "actionlint" }

      vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost" }, {
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },
}

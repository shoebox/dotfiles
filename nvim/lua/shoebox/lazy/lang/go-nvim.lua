return {
  {
    "ray-x/go.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
      "ray-x/guihua.lua",
    },
    config = function()
      require("go").setup({
        lsp_document_formatting = false,
        lsp_cfg = false,
        lsp_diag_update_in_insert = false,
        lsp_inlay_hints = {
          enable = false,
        },
      })
    end,
    ft = { "go", "gomod" },
    keys = {
      {
        "<leader>ga",
        "<cmd>GoAlt<cr>",
        desc = "NeoVim alt view",
      },
    },
  },
}

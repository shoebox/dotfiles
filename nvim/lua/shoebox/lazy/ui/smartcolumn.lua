return {
  {
    "m4xshen/smartcolumn.nvim",
    config = function()
      require("smartcolumn").setup({
        colorcolumn = "100",
      })
    end,
    event = "VeryLazy",
  },
}

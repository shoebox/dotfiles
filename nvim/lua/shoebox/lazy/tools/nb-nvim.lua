return {
  {
    -- "shoebox/nb.nvim",
    dir = "~/Desktop/shoebox/nb-nvim/",
    cmd = {
      "NbAddNote",
      "NbEditNote",
      "NbSelectNotebook",
      "NbToday",
      "NbYesterday",
      "NbTomorrow",
    },
    config = function()
      require("nb-nvim").setup({
        debug = false,
        notebook = "home",
      })
    end,
    dependencies = {
      "nvim-telescope/telescope-ui-select.nvim",
    },
  },
}

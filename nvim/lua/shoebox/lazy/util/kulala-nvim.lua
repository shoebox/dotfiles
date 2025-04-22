return {
  {
    "mistweaverco/kulala.nvim",
    config = function()
      vim.filetype.add({
        extension = {
          http = "http",
        },
      })

      -- Setup is required, even if you don't pass any options
      require("kulala").setup()
    end,
    ft = { "http", "rest" },
    keys = {
      {
        "<leader>kr",
        function()
          require("kulala").run()
        end,
        desc = "Kulala run request",
      },
      {
        "kt",
        function()
          require("kulala").toggle_view()
        end,
        desc = "Kulala toggle view",
      },
    },
  },

}

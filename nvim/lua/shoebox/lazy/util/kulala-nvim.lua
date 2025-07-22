return {
  {
    "mistweaverco/kulala.nvim",
    setup = function()
      vim.filetype.add({
        extension = {
          http = "http",
        },
      })
    end,
    opts = {
      ui = {
        display_mode = "float",
        report = {
          show_script_output = "on_error",
          show_summary = false,
        },
      },
    },
    ft = { "http", "rest" },
    keys = {
      {
        "<leader>kr",
        function()
          require("kulala").run()
        end,
        ft = "http",
        desc = "Kulala run request",
      },
      {
        "<leader>ka",
        function()
          require("kulala").replay()
        end,
        desc = "Kulala replay last request",
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

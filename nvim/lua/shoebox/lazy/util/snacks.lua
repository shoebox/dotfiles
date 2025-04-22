local vim = vim
return {
  {
    "folke/snacks.nvim",
    event = "VimEnter",
    opts = {
      lazygit = {},
      scratch = { height = 50 },
    },
    keys = {
      {
        "<leader>gg",
        function()
          Snacks.lazygit()
        end,
        desc = "Lazygit",
      },
      {
        "<leader>.",
        function()
          Snacks.scratch()
        end,
        desc = "Snacks - Toggle Scratch Buffer",
      },
      {
        "<leader>S",
        function()
          Snacks.scratch.select()
        end,
        desc = "Snacks - Select Scratch Buffer",
      },
    },
  },
}

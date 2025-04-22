return {
  {
    "nvim-telescope/telescope.nvim",
    event = "VeryLazy",
    config = function()
      local telescope = require("telescope")
      telescope.setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
        },
        pickers = {
          find_files = {
            hidden = true,
          },
        },
      })
    end,
    keys = {
      {
        "<leader>p",
        function()
          require("telescope.builtin").live_grep()
        end,
        desc = "Telescope - live grep",
      },
      {
        "<leader>ff",
        function()
          require("telescope.builtin").find_files()
        end,
        desc = "Telescope - Find files",
      },
      {
        "<leader>fg",
        function()
          require("telescope.builtin").git_files()
        end,
        desc = "Telescope - Git files",
      },
      {
        "<C-Q>",
        function()
          require("telescope.builtin").quickfix()
        end,
        desc = "Telescope - quickfix",
      },
    },
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      {
        "nvim-telescope/telescope-ui-select.nvim",
        config = function()
          local telescope = require("telescope")
          telescope.load_extension("ui-select")
        end,
      },
    },
  },
}

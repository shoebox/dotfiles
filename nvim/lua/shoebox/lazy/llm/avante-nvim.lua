return {
  {
    "yetone/avante.nvim",
    cmd = {
      "AvanteAsk",
      "AvanteBuild",
      "AvanteChat",
      "AvanteClear",
      "AvanteEdit",
      "AvanteFocus",
      "AvanteRefresh",
      "AvanteStop",
      "AvanteSwitchProvider",
      "AvanteShowRepoMap",
      "AvanteToggle",
      "AvanteModels",
    },
    version = false, -- Never set this value to "*"! Never!
    opts = {
      provider = "copilot",

      -- hide_in_model_selector
      aihubmix = { hide_in_model_selector = true },
      bedrock = { hide_in_model_selector = true },
      claude = { hide_in_model_selector = true },
      claude_haiku = { hide_in_model_selector = true },
      claude_opus = { hide_in_model_selector = true },
      cohere = { hide_in_model_selector = true },
      gemini = { hide_in_model_selector = true },
      openai = { hide_in_model_selector = true },
      vertex = { hide_in_model_selector = true },

      windows = {
        position = "right",
        width = 50,
        edit = {
          border = "rounded",
          start_insert = true, -- Start insert mode when opening the edit window
        },
      },
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "echasnovski/mini.pick", -- for file_selector provider mini.pick
      "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
      "echasnovski/mini.icons",
      "zbirenbaum/copilot.lua", -- for providers='copilot'
      {
        -- Make sure to set this up properly if you have lazy=true
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {},
      },
    },
    keys = {
      {
        "<leader>aa",
        function()
          require("avante.api").ask()
        end,
      },
      {
        "<leader>a?",
        function()
          require("avante.api").select_model()
        end,
      },
      {
        "<leader>a/",
        "<cmd>AvanteClear<CR>",
        desc = "Avante clear",
      },
      {
        "<leader>aS",
        function()
          require("avante.api").stop()
        end,
      },
    },
  },
}

return {
  {
    "nvim-telescope/telescope.nvim",
    event = "VeryLazy",
    config = function()
      local actions = require("telescope.actions")
      require("telescope").setup({
        defaults = {
          layout_strategy = "vertical",
          layout_config = {
            vertical = { width = 0.65 },
          },
          mappings = {
            i = {
              ["<esc>"] = actions.close,
            },
          },
          sorting_strategy = "ascending",
        },
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
        },
        layout_strategy = "vertical",
        pickers = {
          find_files = {
            hidden = true,
          },
        },
      })

      -- tweak Telescope colors
      local vim = vim or {}
      local comment_conf = vim.api.nvim_get_hl(0, { name = "Comment" })
      local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
      vim.api.nvim_set_hl(0, "TelescopePromptBorder", { fg = comment_conf.fg })
      vim.api.nvim_set_hl(0, "TelescopeResultsBorder", { fg = comment_conf.fg })
      vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { fg = comment_conf.fg })
      vim.api.nvim_set_hl(0, "TelescopeTitle", {
        bg = comment_conf.fg,
        fg = normal.fg,
        bold = true,
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
      {
        "<leader>fm",
        function()
          require("telescope.builtin").lsp_document_symbols({
            symbols = { "method", "function" },
          })
        end,
        desc = "Telescope - Document symbols",
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

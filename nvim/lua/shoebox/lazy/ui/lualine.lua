return {
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("lualine").setup({
        extensions = {
          "lazy",
          "toggleterm",
          "neo-tree",
          "quickfix",
          "trouble",
        },
        sections = {
          lualine_a = { { "mode" } },
          lualine_b = {
            { "branch", color = { gui = "bold" }, icon = "" },
          },
          lualine_c = {
            {
              "diagnostics",
              symbols = {
                error = " ",
                warn = " ",
                info = " ",
                hint = "󰝶 ",
              },
            },
            { "filename" },
          },
          lualine_x = {},
          lualine_y = {},
          lualine_z = {
            {
              "datetime",
              style = " %X",
            },
          },
        },
        options = {
          padding = 1,
          component_separators = "",
          section_separators = { left = "", right = "" },
          globalstatus = true,
        },
      })

      -- vim.cmd([[
      --           highlight lualine_b_inactive guibg=NONE
      --           highlight lualine_c_inactive guibg=NONE
      --
      --           highlight lualine_c_normal guibg=NONE
      --       ]])
    end,
    event = "VeryLazy",
  },
}

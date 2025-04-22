return {
  {
    "dnlhc/glance.nvim",
    cmd = "Glance",
    config = function()
      require("glance").setup({
        detached = true,
        border = { enable = true, top_char = "─", bottom_char = "─" },
        theme = { mode = "brighten" },
        indent_lines = { icon = "│" },
        winbar = { enable = true },
      })
    end,
  },
}

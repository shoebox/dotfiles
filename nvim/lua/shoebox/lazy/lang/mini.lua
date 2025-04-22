return {
  {
    "echasnovski/mini.nvim",
    config = function()
      require("mini.align").setup({})

      require("mini.comment").setup({
        mappings = {
          comment = "<leader>/",
          comment_line = "<leader>/",
          comment_visual = "<leader>/",
          textobject = "<leader>/",
        },
      })

      local hipatterns = require("mini.hipatterns")
      require("mini.hipatterns").setup({
        highlighters = {
          -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
          fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
          hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
          todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
          note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },

          -- Highlight hex color strings (`#rrggbb`) using that color
          hex_color = hipatterns.gen_highlighter.hex_color(),
        },
      })

      require("mini.git").setup({})
      require("mini.icons").setup({})
      require("mini.splitjoin").setup({
        mappings = {
          toggle = "st",
          split = "ss",
          join = "sj",
        },
      })

      -- require("mini.sessions").setup({
      --   autoread = true,
      --   autowrite = true,
      --   verbose = { read = false, write = true, delete = true },
      -- })

      require("mini.trailspace").setup({})
    end,
    event = "VeryLazy",
  },
}

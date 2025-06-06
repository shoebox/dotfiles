return {
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    after = "nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("nvim-treesitter.configs").setup({
        textobjects = {
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
              ["]m"] = "@function.outer",
              ["]]"] = { query = "@class.outer", desc = "Next class start" },
              --
              -- You can use regex matching (i.e. lua pattern) and/or pass a list in a "query" key to group multiple queries.
              ["]o"] = "@loop.*",
              -- ["]o"] = { query = { "@loop.inner", "@loop.outer" } }
              --
              -- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
              -- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
              ["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
              -- ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
            },
            goto_next_end = {
              ["]b"] = { query = "@block.outer", desc = "Next block end" },
              ["]c"] = { query = "@class.outer", desc = "Next class end" },
              ["]f"] = { query = "@function.outer", desc = "Next method/function def end" },
              ["]l"] = { query = "@loop.outer", desc = "Next loop end" },
            },
            goto_previous_start = {
              ["[b"] = { query = "@block.outer", desc = "Prev block start" },
              ["[c"] = { query = "@class.outer", desc = "Prev class start" },
              ["[f"] = { query = "@function.outer", desc = "Prev method/function def start" },
              ["[l"] = { query = "@loop.outer", desc = "Prev loop start" },
            },
            goto_previous_end = {
              ["[B"] = { query = "@class.outer", desc = "Prev class end" },
              ["[C"] = { query = "@block.outer", desc = "Prev block end" },
              ["[F"] = { query = "@function.outer", desc = "Prev method/function def end" },
              ["[L"] = { query = "@loop.outer", desc = "Prev loop end" },
            },
            -- Below will go to either the start or the end, whichever is closer.
            -- Use if you want more granular movements
            -- Make it even more gradual by adding multiple queries and regex.
            goto_next = {
              ["]d"] = "@conditional.outer",
            },
            goto_previous = {
              ["[d"] = "@conditional.outer",
            },
          },
        },
        select = {
          enable = false,

          -- Automatically jump forward to textobj, similar to targets.vim
          lookahead = true,

          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ["a="] = { query = "@assignment.outer", desc = "Select outer part of an assignment" },
            ["i="] = { query = "@assignment.inner", desc = "Select inner part of an assignment" },
            ["l="] = { query = "@assignment.lhs", desc = "Select left hand side of an assignment" },
            ["r="] = { query = "@assignment.rhs", desc = "Select right hand side of an assignment" },

            ["aa"] = {
              query = "@parameter.outer",
              desc = "Select outer part of a parameter/argument",
            },
            ["ia"] = {
              query = "@parameter.inner",
              desc = "Select inner part of a parameter/argument",
            },

            ["ai"] = { query = "@conditional.outer", desc = "Select outer part of a conditional" },
            ["ii"] = { query = "@conditional.inner", desc = "Select inner part of a conditional" },

            ["al"] = { query = "@loop.outer", desc = "Select outer part of a loop" },
            ["il"] = { query = "@loop.inner", desc = "Select inner part of a loop" },

            ["af"] = { query = "@call.outer", desc = "Select outer part of a function call" },
            ["if"] = { query = "@call.inner", desc = "Select inner part of a function call" },

            ["am"] = {
              query = "@function.outer",
              desc = "Select outer part of a method/function definition",
            },
            ["im"] = {
              query = "@function.inner",
              desc = "Select inner part of a method/function definition",
            },

            ["ac"] = { query = "@class.outer", desc = "Select outer part of a class" },
            ["ic"] = { query = "@class.inner", desc = "Select inner part of a class" },
          },
        },
      })
    end,
  },
}

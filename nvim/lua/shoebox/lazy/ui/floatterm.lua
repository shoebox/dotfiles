return {
  {
    "voldikss/vim-floaterm",
    cmd = { "FloatermToggle", "FloatermNew" },
    init = function()
      vim.g.floaterm_shell = "zsh"
      vim.g.floaterm_keymap_toggle = "<F7>"
      vim.g.floaterm_width = 0.9
      vim.g.floaterm_height = 0.9

      local opts = { noremap = true, silent = true }
      vim.keymap.set("n", "<F7>", function()
        vim.cmd("FloatermToggle")
      end, opts)

      vim.keymap.set("t", "<F7>", function()
        vim.cmd("<C-\\><C-n>:FloatermToggle")
      end, opts)
    end,
  },
}

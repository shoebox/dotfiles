return {
  {
    "ray-x/lsp_signature.nvim",
    config = function()
      require("lsp_signature").setup({
        auto_close_after = 200,
        bind = true,
        close_timeout = 200,
        handler_opts = {
          border = "none",
        },
        hint_enable = true,
        max_height = 30,
      })
    end,
    enabled = false,
    event = "VimEnter",
  },
}

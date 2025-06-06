function MyColorScheme(color)
  color = color or "eldritch"
  vim.cmd.colorscheme(color)
end

return {
  {
    "folke/tokyonight.nvim",
    config = function()
      require("tokyonight").setup({
        dim_inactive = false,
        style = "storm",
        styles = {
          -- sidebars = "dark",
          -- floats = "dark",
          sidebars = "transparent",
          floats = "transparent",
        },
        on_highlights = function(hl, c)
          -- hl.Normal = "Foo"
          do
            return
          end
          local prompt = "#2d3149"
          hl.TelescopeNormal = { bg = c.bg_dark, fg = c.fg }
          hl.TelescopeBorder = { bg = c.bg_dark, fg = c.bg_dark }
          hl.TelescopePromptNormal = { bg = prompt }
          hl.TelescopePromptBorder = { bg = prompt, fg = prompt }
          hl.TelescopePromptTitle = { bg = c.fg_gutter, fg = c.orange }
          hl.TelescopePreviewTitle = { bg = c.bg_dark, fg = c.bg_dark }
          hl.TelescopeResultsTitle = { bg = c.bg_dark, fg = c.bg_dark }
        end,
        terminal_colors = true,
        -- transparent = true,
      })
    end,
    lazy = true,
    priority = 1000,
  },
  {
    "loctvl842/monokai-pro.nvim",
    config = function()
      require("monokai-pro").setup()
    end,
    lazy = true,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    config = function()
      require("catppuccin").setup()
    end,
    lazy = true,
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    config = function()
      require("rose-pine").setup({
        disable_background = true,
        styles = {
          italic = false,
        },
      })
    end,
    lazy = true,
  },
  {
    "EdenEast/nightfox.nvim",
    config = function()
      require("nightfox").setup({})
    end,
    lazy = true,
  },
  {
    "eldritch-theme/eldritch.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      dim_inactive = false,
      transparent = false,
      hide_inactive_statusline = true,
      lualine_bold = true,
    },
    init = function()
      MyColorScheme()
    end,
  },
}

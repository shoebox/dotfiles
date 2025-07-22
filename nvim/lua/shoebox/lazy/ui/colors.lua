function MyColorScheme(color)
  color = color or "eldritch"
  vim.cmd.colorscheme(color)

  -- Remove the background color for LspInlayHint
  vim.api.nvim_set_hl(0, "LspInlayHint", { fg = "#969696", bg = "NONE" })
end

return {
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
  {
    "folke/tokyonight.nvim",
    opts = {
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
    },
    lazy = true,
  },
  {
    "olimorris/onedarkpro.nvim",
    opts = {
      highlights = {
        Comment = { italic = true },
        Directory = { bold = true },
        ErrorMsg = { italic = true, bold = true },
      },
      options = {
        cursorline = true, -- Use cursorline highlighting?
        transparency = false, -- Use a transparent background?
        terminal_colors = true, -- Use the theme's colors for Neovim's :terminal?
        lualine_transparency = true, -- Center bar transparency?
        highlight_inactive_windows = false, -- When the window is out of focus, change the normal background?
      },
    },
    lazy = true,
  },
  {
    "loctvl842/monokai-pro.nvim",
    opts = {},
    lazy = true,
  },
  {
    "catppuccin/nvim",
    lazy = true,
    name = "catppuccin",
    opts = {},
  },
  {
    "EdenEast/nightfox.nvim",
    opts = {},
    lazy = true,
  },
  {
    "nyoom-engineering/oxocarbon.nvim",
    lazy = true,
  },
}

function MyColorScheme(color)
    color = color or "tokyonight-night"
    vim.cmd.colorscheme(color)

    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

return {
    {
        "folke/tokyonight.nvim",
        config = function()
            require("tokyonight").setup({
                dim_inactive = false,
                style = "storm",
                styles = {
                    sidebars = "dark",
                    floats = "dark",
                },
                terminal_colors = true,
                -- transparent = true,
            })

            vim.cmd.colorscheme("tokyonight-night")
            MyColorScheme()
        end,
        lazy = false,
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
}

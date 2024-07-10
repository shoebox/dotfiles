return {
    {
        "ray-x/go.nvim",
        dependencies = {
            "neovim/nvim-lspconfig",
            "nvim-treesitter/nvim-treesitter",
            "ray-x/guihua.lua",
        },
        config = function()
            require("go").setup({
                trouble = true,
                lsp_cfg = false,
                lsp_codelens = true,
                -- lsp_gofumpt = true,
                -- lsp_diag_update_in_insert = true,
                -- lsp_document_formatting = true,
                diagnostic = {
                    virtual_text = { prefix = "🐹" },
                    -- signs = true,
                    -- update_in_insert = false,
                },
                lsp_inlay_hints = {
                    enable = false,
                },
            })
        end,
        ft = { "go", "gomod" },
    },
}

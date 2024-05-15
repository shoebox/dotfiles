return {
	{
		"ray-x/lsp_signature.nvim",
		config = function()
			require("lsp_signature").setup({
				auto_close_after = 200,
				bind = true,
				close_timeout = 200,
				doc_lines = 20,
				noice = true,
				transparency = 10,
				wrap = true,
			})
		end,
	},
}

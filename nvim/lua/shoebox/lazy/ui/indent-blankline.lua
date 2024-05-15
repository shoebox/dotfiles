return {
	{
	"lukas-reineke/indent-blankline.nvim",
	config = function()
		require("ibl").setup({
			enabled = true,
			scope = { enabled = false },
		})
	end,
	event = { "BufRead", "BufNewFile" },
},
}

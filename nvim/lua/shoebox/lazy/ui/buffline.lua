return {
	{
		"akinsho/bufferline.nvim",
		config = function()
			require("bufferline").setup({
				options = {
					mode = "tabs",
					numbers = "ordinal",
					offsets = {
						{
							filetype = "NvimTree",
							text = "File Explorer",
							text_align = "left",
						},
					},
					separator_style = " ",
					show_buffer_close_icons = false,
					show_buffer_icons = false,
					show_duplicate_prefix = false,
					themable = true,
				},
			})

			local opts = { noremap = true, silent = true }
			vim.keymap.set("n", "<space>1", function()
				vim.cmd("BufferLineGoToBuffer 1")
			end, opts)
			vim.keymap.set("n", "<space>2", function()
				vim.cmd("BufferLineGoToBuffer 2")
			end, opts)
			vim.keymap.set("n", "<space>3", function()
				vim.cmd("BufferLineGoToBuffer 3")
			end, opts)
			vim.keymap.set("n", "<space>4", function()
				vim.cmd("BufferLineGoToBuffer 4")
			end, opts)
			vim.keymap.set("n", "<space>5", function()
				vim.cmd("BufferLineGoToBuffer 5")
			end, opts)
			vim.keymap.set("n", "<space>6", function()
				vim.cmd("BufferLineGoToBuffer 6")
			end, opts)
			vim.keymap.set("n", "<space>7", function()
				vim.cmd("BufferLineGoToBuffer 7")
			end, opts)
			vim.keymap.set("n", "<space>8", function()
				vim.cmd("BufferLineGoToBuffer 8")
			end, opts)
			vim.keymap.set("n", "<space>9", function()
				vim.cmd("BufferLineGoToBuffer 9")
			end, opts)
		end,
		event = "VeryLazy",
	},
}

local focus_group = vim.api.nvim_create_augroup("focus_group", { clear = true })

vim.api.nvim_create_autocmd({ "FocusLost" }, {
	group = focus_group,
	pattern = { "*" },
	command = ":wa",
})

vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
	group = focus_group,
	pattern = { "*" },
	command = "checktime",
})

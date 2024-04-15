-- Avoid multiple linting issues
local vim = vim

local autocmd = {}

function autocmd.load_autocmds()
	local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

	vim.api.nvim_create_autocmd({ "FocusLost" }, {
		pattern = { "*" },
		command = ":wa",
	})

	vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
		pattern = { "*" },
		command = "checktime",
	})

end

autocmd.load_autocmds()

return autocmd

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

	local format_sync_grp = vim.api.nvim_create_augroup("GoImport", {})
	vim.api.nvim_create_autocmd("BufWritePre", {
		pattern = "*.go",
		callback = function()
			require("go.format").goimport()
		end,
		group = format_sync_grp,
	})
end

autocmd.load_autocmds()

return autocmd

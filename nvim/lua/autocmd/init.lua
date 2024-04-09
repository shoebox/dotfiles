-- Avoid multiple linting issues
local vim = vim

local autocmd = {}

function autocmd.load_autocmds()
    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
	-- vim.api.nvim_create_autocmd({
	--        "BufReadPost",
	--        "BufWritePost",
	--        'InsertLeave',
	--    }, {
	--     command = "Neoformat",
	-- 	group = lint_augroup,
	-- })

	vim.api.nvim_create_autocmd({
        "BufReadPost",
        "BufWritePre",
    }, {
		callback = function()
			require("lint").try_lint()
		end,
		group = lint_augroup,
	})

	vim.api.nvim_create_autocmd({
	    "BufWritePre",
	}, {
		pattern = { "*" },
		callback = function()
			vim.lsp.buf.format()
		end,
	})

	vim.api.nvim_create_autocmd({ "FocusLost" }, {
		pattern = { "*" },
		command = ":wa",
	})

	vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
		pattern = { "*" },
		command = "checktime",
	})

	-- vim.api.nvim_create_autocmd({ "CursorHold" }, {
	--     callback = function()
	--         vim.lsp.buf.document_highlight()
	--     end,
	--     group = lint_augroup,
	-- })
	--
	-- vim.api.nvim_create_autocmd({ "CursorMoved" }, {
	--     callback = function()
	--         vim.lsp.buf.clear_references()
	--     end,
	--     group = lint_augroup,
	-- })
	--
	local format_sync_grp = vim.api.nvim_create_augroup("GoImport", {})
    vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*.go",
        callback = function()
            require('go.format').goimport()
        end,
        group = format_sync_grp,
    })

	-- local go_format_grp = vim.api.nvim_create_augroup("GoFormat", {})
	--    vim.api.nvim_create_autocmd({ "BufWritePre", "BufReadPost", }, {
	--        pattern = {'*.go'},
	--        callback = function()
	--            vim.lsp.buf.format()
	--        end,
	--        group = go_format_grp,
	--    })
end

autocmd.load_autocmds()

return autocmd

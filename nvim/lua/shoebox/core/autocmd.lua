local vim = vim

vim.o.autoread = true

local focus_group = vim.api.nvim_create_augroup("focus_group", {})

local exclude = { "neo-tree", "kulala://ui" }

vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost" }, {
	group = focus_group,
	pattern = { "*" },
	callback = function(args)
		if not vim.bo[args.buf].readonly then
			local buftype = vim.api.nvim_get_option_value("buftype", { buf = args.buf })
			local ignore_buftype = {
				"acwrite",
				"filesystem",
				"nofile",
				"nowrite",
				"prompt",
				"terminal",
			}
			local ignore_buffername = { "", " " }
			if not vim.tbl_contains(ignore_buftype, buftype) then
				local bufferName = vim.api.nvim_buf_get_name(0)
				if not vim.tbl_contains(ignore_buffername, bufferName) then
					vim.cmd.w({ mods = { silent = true } })
				end
			end
		end
	end,
})

vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained" }, {
	group = focus_group,
	callback = function()
		local bufferName = vim.api.nvim_buf_get_name(0)
		if not vim.tbl_contains(exclude, bufferName) then
			vim.cmd("checktime")
		end
	end,
	pattern = { "*" },
})

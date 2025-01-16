local vim = vim

vim.o.autoread = true

local focus_group = vim.api.nvim_create_augroup("focus_group", {})

local exclude = { "neo-tree", "kulala://ui" }

local ignore_buftype = {
	"acwrite",
	"filesystem",
	"nofile",
	"nowrite",
	"prompt",
	"terminal",
}

vim.api.nvim_create_user_command("CloseBuffersNotInWorkspace", function()
	local workspace = vim.fn.getcwd() .. "/" -- Adding "/" at the end to ensure that it's a directory path
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if not vim.api.nvim_buf_is_loaded(buf) then
			goto continue
		end

		local filepath = vim.api.nvim_buf_get_name(buf)
		if vim.startswith(filepath, workspace) then
			goto continue
		end

		-- Close the buffer
		vim.notify(("Closing buffer %s"):format(filepath))

		vim.api.nvim_buf_delete(buf, { force = true })
		::continue::
	end
end, { desc = "Close all buffers not into workspace" })

vim.api.nvim_create_user_command("CloseBuffersExpectCurrent", function()
	vim.cmd("%bdelete|edit#|bdelete#")
end, { desc = "Close all buffer but current one" })

vim.api.nvim_create_user_command("WipeWindowlessBufs", function()
	local bufinfos = vim.fn.getbufinfo({ buflisted = true })
	vim.tbl_map(function(bufinfo)
		if bufinfo.changed == 0 and (not bufinfo.windows or #bufinfo.windows == 0) then
			vim.notify(("Deleting buffer %d : %s"):format(bufinfo.bufnr, bufinfo.name))
			vim.api.nvim_buf_delete(bufinfo.bufnr, { force = false, unload = false })
		end
	end, bufinfos)
end, { desc = "Wipeout all buffers not shown in a window" })

vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost" }, {
	group = focus_group,
	pattern = { "*" },
	callback = function(args)
		local bufid = vim.api.nvim_get_current_buf()
		vim.api.nvim_clear_autocmds({ group = focus_group, buffer = bufid })

		if not vim.bo[args.buf].readonly then
			local buftype = vim.api.nvim_get_option_value("buftype", { buf = args.buf })
			local modifiable = vim.api.nvim_get_option_value("modifiable", { buf = args.buf })
			local ignore_buffername = { "", " " }

			if modifiable and not vim.tbl_contains(ignore_buftype, buftype) then
				local bufferName = vim.api.nvim_buf_get_name(0)
				local infos = vim.fn.getbufinfo(bufid)

				-- do the buffer has any changes
				local changed = 0
				if type(infos) == "table" and #infos >= 1 then
					changed = infos[1].changed
				end

				-- if the buffer is not excluded and has changes
				if not vim.tbl_contains(ignore_buffername, bufferName) and changed == 1 then
					-- writing the file silently
					vim.cmd.w({ mods = { silent = true } })
				end
			end
		end
	end,
})

-- vim.api.nvim_create_autocmd({ "InsertLeave" }, {
-- 	group = focus_group,
-- 	callback = function()
-- 		vim.cmd("set relativenumber")
-- 	end,
-- 	pattern = { "*" },
-- })
--
-- vim.api.nvim_create_autocmd({ "InsertLeave" }, {
-- 	group = focus_group,
-- 	callback = function()
-- 		vim.cmd("set norelativenumber")
-- 	end,
-- 	pattern = { "*" },
-- })

vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained" }, {
	group = focus_group,
	callback = function()
		-- clear
		local bufid = vim.api.nvim_get_current_buf()
		vim.api.nvim_clear_autocmds({ group = focus_group, buffer = bufid })

		local bufferName = vim.api.nvim_buf_get_name(0)
		if not vim.tbl_contains(exclude, bufferName) then
			vim.cmd("checktime")
		end
	end,
	pattern = { "*" },
})

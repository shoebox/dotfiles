local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=v10.22.2", -- latest stable release
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

local lazy = require("lazy")

lazy.setup({
	{ import = "shoebox.lazy.completion" },
	{ import = "shoebox.lazy.lang" },
	{ import = "shoebox.lazy.lsp" },
	{ import = "shoebox.lazy.tools" },
	{ import = "shoebox.lazy.ui" },
	{ import = "shoebox.lazy.util" },
})
-- lazy.setup({
--
-- 	{ import = "shoebox.lazy.lang" },
-- 	-- spec = {
-- 	-- 	{ "LazyVim/LazyVim", import = "shoebox.lazy.completion" },
-- 	-- 	{ "LazyVim/LazyVim", import = "shoebox.lazy.lang" },
-- 	-- 	{ "LazyVim/LazyVim", import = "shoebox.lazy.lsp" },
-- 	-- 	{ "LazyVim/LazyVim", import = "shoebox.lazy.tools" },
-- 	-- 	{ "LazyVim/LazyVim", import = "shoebox.lazy.ui" },
-- 	-- 	{ "LazyVim/LazyVim", import = "shoebox.lazy.util" },
-- 	-- },
-- 	change_detection = { notify = true },
-- })

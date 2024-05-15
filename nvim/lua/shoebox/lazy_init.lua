local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	spec = {
		{ "LazyVim/LazyVim", import = "shoebox.lazy" },
		{ "LazyVim/LazyVim", import = "shoebox.lazy.completion" },
		{ "LazyVim/LazyVim", import = "shoebox.lazy.lang" },
		{ "LazyVim/LazyVim", import = "shoebox.lazy.lsp" },
		{ "LazyVim/LazyVim", import = "shoebox.lazy.tools" },
		{ "LazyVim/LazyVim", import = "shoebox.lazy.ui" },
		{ "LazyVim/LazyVim", import = "shoebox.lazy.util" },
	},
	change_detection = { notify = true },
})

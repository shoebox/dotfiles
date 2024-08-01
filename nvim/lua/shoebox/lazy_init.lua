local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
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

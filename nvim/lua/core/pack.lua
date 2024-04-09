-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd([[packadd packer.nvim]])

local p = require("packer")

return p.startup(function()
	-- Packer can manage itself
	p.use("wbthomason/packer.nvim")

	-- Lang module
	require("modules.lang.plugins").packer()

	-- UI module
	require("modules.ui.plugins").packer()

	-- LSP
	require("modules.lsp.plugins").packer()

	-- Tool
	require("modules.tool.plugins").packer()
end)

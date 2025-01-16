local bind = require("shoebox.mapping.helper")
local map_cr = bind.map_cr
local map_cmd = bind.map_cmd

local global_clipb = {
	["v|<leader>c"] = map_cmd('"+y'):with_noremap():with_silent(),
	["i|<leader>c"] = map_cmd('"+y'):with_noremap():with_silent(),
	["n|<leader>c"] = map_cmd('"+y'):with_noremap():with_silent(),
}

local global_nav = {
	["n|<space><Left>"] = map_cmd("<C-W>h"),
	["v|<space><Left>"] = map_cmd("<C-W>h"),
	["n|<space><Right>"] = map_cmd("<C-W>l"),
	["v|<space><Right>"] = map_cmd("<C-W>l"),
	["n|<space><Up>"] = map_cmd("<C-W>k"),
	["v|<space><Up>"] = map_cmd("<C-W>k"),
	["n|<space><Down>"] = map_cmd("<C-W>j"),
	["v|<space><Down>"] = map_cmd("<C-W>j"),
}

local global_git = {
	["n|g/"] = map_cr("G add % | G diff --staged | G commit"):with_noremap():with_silent(),
	["n|gP"] = map_cr("G push"):with_noremap():with_silent(),
	["v|gP"] = map_cr("G push"):with_noremap():with_silent(),
	["t|gP"] = map_cr("G push"):with_noremap():with_silent(),
}

vim.keymap.set({ "n", "x" }, "<c-s>", "<cmd>w<CR>")

local nb = function()
	local opts = { noremap = true, silent = false }
	vim.keymap.set("n", "<leader>wt", ":e `='~/.nb/home/Journal/' . expand(strftime('%Y-%m-%d')) . '.adoc'` <CR>", opts)
end

bind.nvim_load_mapping(global_clipb)
bind.nvim_load_mapping(global_git)
bind.nvim_load_mapping(global_nav)

nb()

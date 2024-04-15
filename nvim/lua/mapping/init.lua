local bind = require("mapping.helper")
local map_cr = bind.map_cr
local map_cu = bind.map_cu
local map_cmd = bind.map_cmd

local leader_map = function()
	--  vim.g.mapleader = "/"
end

local plugin_telescope = {
	["n|<leader>p"] = map_cu("Telescope live_grep"):with_noremap():with_silent(),
	["n|<leader>fb"] = map_cu("Telescope file_browser"):with_noremap():with_silent(),
	["n|<leader>ff"] = map_cu("Telescope find_files"):with_noremap():with_silent(),
	["n|<leader>fg"] = map_cu("Telescope git_files"):with_noremap():with_silent(),
	["n|<leader>ft"] = map_cu("Telescope help_tags"):with_noremap():with_silent(),
	["n|<C-Q>"] = map_cr("lua require('telescope.builtin').quickfix()"):with_noremap():with_silent(),
}

local plugin_nvimtree = {
	["n|<space>n"] = map_cr("NvimTreeToggle"):with_noremap():with_silent(),
}

local plugin_floatterm = {
	["n|<F7>"] = map_cr("ToggleTerm"):with_noremap():with_silent(),
	["t|<F7>"] = map_cr("<C-\\><C-n>:ToggleTerm"):with_noremap():with_silent(),
}

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

local global_tabs = {
	["n|<space>1"] = map_cu("BufferLineGoToBuffer 1"):with_silent(),
	["n|<space>2"] = map_cu("BufferLineGoToBuffer 2"):with_silent(),
	["n|<space>3"] = map_cu("BufferLineGoToBuffer 3"):with_silent(),
	["n|<space>4"] = map_cu("BufferLineGoToBuffer 4"):with_silent(),
	["n|<space>5"] = map_cu("BufferLineGoToBuffer 5"):with_silent(),
	["n|<space>6"] = map_cu("BufferLineGoToBuffer 6"):with_silent(),
	["n|<space>7"] = map_cu("BufferLineGoToBuffer 7"):with_silent(),
	["n|<space>8"] = map_cu("BufferLineGoToBuffer 8"):with_silent(),
	["n|<space>9"] = map_cu("BufferLineGoToBuffer 9"):with_silent(),
}

local plugin_dap = function()
	vim.keymap.set("n", "<F5>", function()
		require("dap").continue()
	end)
	vim.keymap.set("n", "<F2>", function()
		require("dap").step_over()
	end)
	vim.keymap.set("n", "<F3>", function()
		require("dap").step_into()
	end)
	vim.keymap.set("n", "<F4>", function()
		require("dap").step_out()
	end)
	vim.keymap.set("n", "<Leader>b", function()
		require("dap").toggle_breakpoint()
	end)
	vim.keymap.set("n", "<Leader>B", function()
		require("dap").set_breakpoint()
	end)
	vim.keymap.set("n", "<Leader>lp", function()
		require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
	end)
	vim.keymap.set("n", "<Leader>dr", function()
		require("dap").repl.open()
	end)
	vim.keymap.set("n", "<Leader>dl", function()
		require("dap").run_last()
	end)
	vim.keymap.set({ "n", "v" }, "<Leader>dh", function()
		require("dap.ui.widgets").hover()
	end)
	vim.keymap.set({ "n", "v" }, "<Leader>dp", function()
		require("dap.ui.widgets").preview()
	end)
	vim.keymap.set("n", "<Leader>df", function()
		local widgets = require("dap.ui.widgets")
		widgets.centered_float(widgets.frames)
	end)
	vim.keymap.set("n", "<Leader>ds", function()
		local widgets = require("dap.ui.widgets")
		widgets.centered_float(widgets.scopes)
	end)
	vim.keymap.set("n", "<Leader>do", function()
		local ui = require("dapui")
		ui.open()
	end)
	vim.keymap.set("n", "<Leader>dc", function()
		local ui = require("dapui")
		ui.close()
	end)
end

local plugin_overseer = {
	["n|<leader>or"] = map_cu("OverseerRun"),
	["n|<leader>ot"] = map_cu("OverseerToggle bottom"),
}

local plugin_hop = function()
	local hop = require("hop")
	local directions = require("hop.hint").HintDirection
	vim.keymap.set("", "<leader>f", function()
		hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
	end, { remap = true })
	vim.keymap.set("", "<leader>F", function()
		hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
	end, { remap = true })
	vim.keymap.set("", "<leader>t", function()
		hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
	end, { remap = true })
	vim.keymap.set("", "<leader>T", function()
		hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
	end, { remap = true })
end

local lsp_diagnostics = function()
	local opts = { noremap = true, silent = true }
	vim.keymap.set("n", "<leader>dl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
	vim.keymap.set("n", "<leader>dn", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
	vim.keymap.set("n", "<leader>dp", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
	vim.keymap.set("n", "<leader>dh", "<cmd>lua vim.diagnostic.hide()<CR>", opts)
	vim.keymap.set("n", "<leader>ds", "<cmd>lua vim.diagnostic.show()<CR>", opts)
end

vim.keymap.set("n", "<-s", "<cmd>w<CR")

local plugin_lazygit = {
	["n|<leader>gg"] = map_cr("LazyGit"):with_noremap():with_silent(),
}

local plugin_vim_easyalign = {
	["n|<leader>ga"] = map_cr("EasyAlign"):with_noremap():with_silent(),
	["x|<leader>ga"] = map_cr("EasyAlign"):with_noremap():with_silent(),
}

local nb = function()
	local opts = { noremap = true, silent = false }
	vim.keymap.set("n", "<leader>wt", ":e `='~/.nb/home/Journal/' . expand(strftime('%Y-%m-%d')) . '.adoc'` <CR>", opts)
end

local gen = function()
	vim.keymap.set({ "n", "v" }, "<leader>]", ":Gen<CR>")
end

leader_map()
bind.nvim_load_mapping(global_clipb)
bind.nvim_load_mapping(global_git)
bind.nvim_load_mapping(global_nav)
bind.nvim_load_mapping(global_tabs)
bind.nvim_load_mapping(plugin_floatterm)
bind.nvim_load_mapping(plugin_nvimtree)
bind.nvim_load_mapping(plugin_overseer)
bind.nvim_load_mapping(plugin_telescope)
bind.nvim_load_mapping(plugin_lazygit)
bind.nvim_load_mapping(plugin_vim_easyalign)

plugin_hop()
plugin_dap()
lsp_diagnostics()

nb()
gen()

vim.keymap.set("x", "<leader>re", function()
	require("refactoring").refactor("Extract Function")
end)

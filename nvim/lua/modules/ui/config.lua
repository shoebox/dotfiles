-- Avoid multiple linting issues
local vim = vim
local config = {}


function config.twilight()
	require("twilight").setup({})
end

function config.whichkey()
	require("which-key").setup({})
end

function config.floatterm()
end

function config.lualine()
	local function selected_line()
		local mode = vim.api.nvim_get_mode().mode
		if mode == "v" or mode == "V" then
			return "(" .. vim.fn.abs(vim.fn.line(".") - vim.fn.line("v")) + 1 .. ")"
		end
		return ""
	end

	require("lualine").setup({
		extensions = { "quickfix", "overseer" },
		sections = {
			lualine_a = { "mode" },
			lualine_b = {
				"require'lsp-status'.status()",
			},
			lualine_c = { "filename" },
			lualine_x = { "fileformat", "filetype" },
			lualine_y = { "overseer", "diff" },
			lualine_z = { "location", selected_line },
		},
		options = {
			section_separators = { left = "", right = "" },
			component_separators = { left = "", right = "" },
			globalstatus = true,
		},
	})
end

function config.lightbulb()
	require("nvim-lightbulb").setup({})
end

function config.bufferline_nvim()
	require("bufferline").setup({
		options = {
			always_show_bufferline = true,
			show_buffer_icons = false,
			color_icons = true,
			diagnostics = "nvim_lsp",
			mode = "tabs",
			numbers = "ordinal",
			separator_style = "thick",
			show_buffer_close_icons = false,
			show_duplicate_prefix = false,
			show_tab_indicators = true,
		},
	})
end

return config

-- Avoid multiple linting issues
local vim = vim

local global = require("core.global")

local function bind_option(options)
	for k, v in pairs(options) do
		if v == true or v == false then
			vim.cmd("set " .. k)
		else
			vim.cmd("set " .. k .. "=" .. v)
		end
	end
end

local function load_options()
	local global_local = {
		-- clipboard = "unnamed",
		-- complete = ".,w,b,k",
		-- completeopt = "menuone,noselect",
		-- display = "lastline",
		-- encoding = "utf-8",
		-- hidden = true,
		-- history = 2000,
		backspace = "indent,eol,start",
		backup = false,
		backupdir = global.cache_dir .. "backup/",
		backupskip = "/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*,/private/var/*",
		cmdheight=0,
		cmdwinheight = 5,
		directory = global.cache_dir .. "swag/",
		-- helpheight = 12,
		ignorecase = true,
		inccommand = "nosplit",
		incsearch = true,
		infercase = true,
		laststatus = 2,
		magic = true,
		pumheight = 15,
		ruler = true,
		scrolloff = 2,
		shiftround = true,
		showcmd = false,
		showmode = false,
		showtabline = 1,
		sidescrolloff = 5,
		smartcase = true,
		smartindent = true,
		smarttab = true,
		splitbelow = true,
		splitright = true,
		startofline = false,
		swapfile = false,
		switchbuf = "useopen",
		timeoutlen = 500,
		ttimeout = false,
		ttimeoutlen = 0,
		undodir = global.cache_dir .. "undo/",
		viewdir = global.cache_dir .. "view/",
		virtualedit = "block",
		wildignore = ".git,.hg,.svn,*.pyc,*.o,*.out,*.jpg,*.jpeg,*.png,*.gif,*.zip,**/tmp/**,*.DS_Store,**/node_modules/**,**/bower_modules/**",
		wildignorecase = true,
		winminwidth = 0,
		winwidth = 30,
		writebackup = false,
	}

	local bw_local = {
		undofile = true,
		synmaxcol = 2500,
		formatoptions = "1jcroql",
		textwidth = 80,
		autoindent = true,
		tabstop = 4,
		shiftwidth = 4,
		softtabstop = -1,
		breakindentopt = "shift:2,min:20",
		number = true,
		relativenumber = true,
		copyindent = true,
		expandtab = true,
		colorcolumn = "100",
		foldenable = false,
		signcolumn = "yes",
		conceallevel = 0,
		-- in which mode the cursor can be concelead
		concealcursor = "niv",
		cursorline = true,
		-- show line and column number for current cursor position
		ruler = true,
		-- showmode = true,
		-- show matching bracket
		showmatch = true,
		-- guitablabel = "%t", --%{substitute(expand('%:p'),'/\\zs\\(.\\)[^/]*\\ze/','\\1','g')}",
		hlsearch = true,
	}

	for name, value in pairs(global_local) do
		vim.o[name] = value
	end

	bind_option(bw_local)
end

vim.cmd([[
    set autoread     " reload file if the file changes on the disk
    set autowrite    " Write when switcing buffers
    set autowriteall " Write on :quit
	set scl=auto
]])

-- Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
-- delays and poor user experience.
vim.opt.updatetime = 50

-- Enables 24-bit RGB color in the TUI
vim.opt.termguicolors = true

load_options()

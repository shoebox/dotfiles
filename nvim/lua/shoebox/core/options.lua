vim.cmd([[
    set autoread     " reload file if the file changes on the disk
    set autowrite    " Write when switching buffers
    set autowriteall " Write on :quit
	set scl=auto
]])

vim.opt.autoread = true
vim.opt.autowrite = true
vim.opt.autowriteall = true

vim.opt.cmdheight = 0
-- vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "100"

-- local global = require("shoebox.core.global")
--
-- local function bind_option(options)
-- 	for k, v in pairs(options) do
-- 		if v == true or v == false then
-- 			vim.cmd("set " .. k)
-- 		else
-- 			vim.cmd("set " .. k .. "=" .. v)
-- 		end
-- 	end
-- end
--
-- local function load_options()
-- 	local global_local = {
-- 		-- directory = global.cache_dir .. "swap/",
-- 		undodir = global.cache_dir .. "undo/",
-- 		viewdir = global.cache_dir .. "view/",
--
-- 		backup = false,
-- 		-- backupdir = global.cache_dir .. "backup/",
--
-- 		backspace = "indent,eol,start",
-- 		backupskip = "/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*,/private/var/*",
-- 		cmdheight = 0,
-- 		cmdwinheight = 5,
-- 		ignorecase = true,
-- 		inccommand = "nosplit",
-- 		incsearch = true,
-- 		infercase = true,
-- 		laststatus = 2,
-- 		magic = true,
-- 		pumheight = 15,
-- 		ruler = true,
-- 		scrolloff = 2,
-- 		shiftround = true,
-- 		showcmd = false,
-- 		-- showmode = false,
-- 		showtabline = 1,
-- 		sidescrolloff = 5,
-- 		smartcase = true,
-- 		smartindent = true,
-- 		smarttab = true,
-- 		-- splitbelow = true,
-- 		splitright = true,
-- 		startofline = false,
-- 		swapfile = false,
-- 		switchbuf = "useopen",
-- 		timeoutlen = 500,
-- 		ttimeout = false,
-- 		ttimeoutlen = 0,
-- 		virtualedit = "block",
-- 		wildignore = ".git,.hg,.svn,*.pyc,*.o,*.out,*.jpg,*.jpeg,*.png,*.gif,*.zip,**/tmp/**,*.DS_Store,**/node_modules/**,**/bower_modules/**",
-- 		wildignorecase = true,
-- 		winminwidth = 0,
-- 		winwidth = 30,
-- 		writebackup = false,
-- 	}
--
-- 	local bw_local = {
-- 		autoindent = true,
-- 		breakindentopt = "shift:2,min:20",
-- 		colorcolumn = "100",
-- 		concealcursor = "niv",
-- 		-- conceallevel = 0,
-- 		copyindent = true,
-- 		cursorline = true,
-- 		expandtab = true,
-- 		foldenable = false,
-- 		formatoptions = "1jcroql",
-- 		hlsearch = true,
-- 		number = true,
-- 		relativenumber = true,
-- 		ruler = false,
-- 		shiftwidth = 4,
-- 		showmatch = true,
-- 		signcolumn = "yes",
-- 		softtabstop = -1,
-- 		synmaxcol = 2500,
-- 		tabstop = 4,
-- 		textwidth = 80,
-- 		undofile = true,
-- 	}
--
-- 	for name, value in pairs(global_local) do
-- 		vim.o[name] = value
-- 	end
--
-- 	bind_option(bw_local)
-- end
--
--
-- -- Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
-- -- delays and poor user experience.
-- vim.opt.updatetime = 50
--
-- -- Enables 24-bit RGB color in the TUI
-- vim.opt.termguicolors = true
--
-- load_options()

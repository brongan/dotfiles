---------------------------------------------------------------
-- => XDG path configuration
---------------------------------------------------------------
table.insert(vim.opt.runtimepath, os.getenv("XDG_CONFIG_HOME") .. "/nvim")
table.insert(vim.opt.runtimepath, os.getenv("XDG_DATA_HOME") .. "nvim")
table.insert(vim.opt.runtimepath, os.getenv("XDG_DATA_HOME") .. "after")
table.insert(vim.opt.packpath, os.getenv("XDG_CONFIG_HOME") .. "nvim")
table.insert(vim.opt.packpath, os.getenv("XDG_DATA_HOME") .. "nvim")
table.insert(vim.opt.packpath, os.getenv("XDG_DATA_HOME") .. "nvim/after")
vim.opt.backupdir = os.getenv("XDG_CACHE_HOME") .. "vim/backup"
vim.opt.directory = os.getenv("XDG_CACHE_HOME") .. "vim/swap"
vim.opt.undodir = os.getenv("XDG_CACHE_HOME") .. "vim/undo"

---------------------------------------------------------------
-- => Files, backup and undo
---------------------------------------------------------------
vim.opt.backup = false
vim.opt.wb = false
vim.opt.swapfile = false

---------------------------------------------------------------
-- => This is not an error
---------------------------------------------------------------
vim.g.loaded_python3_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

---------------------------------------------------------------
-- => General
---------------------------------------------------------------
vim.g.oscyank_term = "default"
vim.g.symbols_outline = { auto_preview = true, position = "left" }
vim.opt.autochdir = false
vim.opt.autoindent = true
vim.opt.autoread = true
vim.opt.background = "dark"
vim.opt.breakindent = true
vim.opt.cmdheight = 2
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.conceallevel = 0
vim.opt.cursorline = true
vim.opt.encoding = "utf-8"
vim.opt.expandtab = false
vim.opt.formatoptions:remove("cro")
vim.opt.guicursor = ""
vim.opt.hidden = true
vim.opt.history = 500
vim.opt.hlsearch = false
vim.opt.ignorecase = true
vim.opt.inccommand = "split"
vim.opt.iskeyword:append("-")
vim.opt.list = true
vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.ruler = true
vim.opt.scrolloff = 10
vim.opt.shiftwidth = 4
vim.opt.shortmess:append("c")
vim.opt.showmode = false
vim.opt.showtabline = 4
vim.opt.signcolumn = "yes"
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.smarttab = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.syntax = "enable"
vim.opt.tabstop = 4
vim.opt.termguicolors = true
vim.opt.timeoutlen = 300
vim.opt.updatetime = 250
vim.opt.wrap = true
vim.opt.listchars = { tab = "▏ ", trail = "·", nbsp = "␣" }

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

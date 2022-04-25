---------------------------------------------------------------
-- => XDG path configuration
---------------------------------------------------------------
table.insert(vim.opt.runtimepath, os.getenv("XDG_CONFIG_HOME").."/nvim")
table.insert(vim.opt.runtimepath, os.getenv("XDG_DATA_HOME").."nvim")
table.insert(vim.opt.runtimepath, os.getenv("XDG_DATA_HOME").."after")
table.insert(vim.opt.packpath, os.getenv("XDG_CONFIG_HOME").."nvim")
table.insert(vim.opt.packpath, os.getenv("XDG_DATA_HOME").."nvim")
table.insert(vim.opt.packpath, os.getenv("XDG_DATA_HOME").."nvim/after")
vim.opt.backupdir=os.getenv("XDG_CACHE_HOME").."vim/backup"
vim.opt.directory=os.getenv("XDG_CACHE_HOME").."vim/swap"
vim.opt.undodir=os.getenv("XDG_CACHE_HOME").."vim/undo"

---------------------------------------------------------------
-- => Files, backup and undo
---------------------------------------------------------------

vim.opt.backup = false
vim.opt.wb = false
vim.opt.swapfile = false

---------------------------------------------------------------
-- => General
---------------------------------------------------------------

vim.opt.autochdir = true
vim.opt.autoindent = true
vim.opt.autoread = true
vim.opt.background = "dark"
vim.o.completeopt = "menuone,noselect"
vim.opt.clipboard = "unnamedplus"
vim.opt.cmdheight = 2
vim.opt.completeopt = "menuone,noinsert,noselect"
vim.opt.conceallevel = 0
vim.opt.cursorline = true
vim.opt.encoding = "utf-8"
vim.opt.expandtab = false
vim.opt.fileencoding = "utf-8"
vim.opt.formatoptions:remove("cro")
vim.opt.hidden = true
vim.opt.history=500
vim.opt.iskeyword:append("-")
vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.ruler = true
vim.opt.shiftwidth = 4
vim.opt.shortmess:append("c")
vim.opt.showtabline = 4
vim.opt.smartindent = true
vim.opt.smarttab = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.syntax = "enable"
vim.opt.tabstop = 4
vim.opt.termguicolors = true
vim.opt.termguicolors = true
vim.opt.textwidth = 80
vim.opt.timeoutlen = 500
vim.opt.updatetime = 300
vim.opt.wrap = true


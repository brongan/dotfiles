if vim.loader then vim.loader.enable() end

vim.g.mapleader = ","
vim.g.maplocalleader = ","

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
---@diagnostic disable-next-line: undefined-field
if not vim.uv.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end

-- Add lazy to the `runtimepath`, this allows us to `require` it.
vim.opt.rtp:prepend(lazypath)

require("basics")
require("mappings")
require("lazy").setup(require("plugins"), {
	ui = {
		border = "rounded",
	},
	checker = { enabled = true, notify = false },
	change_detection = { notify = false },
})

if not pcall(vim.cmd.colorscheme, "catppuccin") then
	vim.cmd.colorscheme("default")
end

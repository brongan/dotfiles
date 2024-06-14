vim.g.mapleader = ","
vim.g.maplocalleader = ','

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

local ok, google = pcall(require, "google")
if ok then
	google.init()
	print("Loaded Google config.")
else
	print("Loaded Personal config.")
end

require("lazy").setup(require("plugins"), {});
require("ibl").setup()

vim.cmd.colorscheme "catppuccin"

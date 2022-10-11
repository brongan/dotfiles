require("globals")
require("basics")
require("plugins")
require("mappings")
require("navigation")

local ok, _ = pcall(vim.cmd, "colorscheme gruvbox")
if not ok then
	print("gruvbox not installed run :PackerSync")
end

require("configs.bash-language-server")
require("configs.bufferline")
require("configs.flutter-tools")
require("configs.indent-blankline")
require("configs.lsp")
require("configs.lualine")
require("configs.nvim-cmp")
require("configs.nvim-colorizer")
require("configs.nvim-dap-ui")
require("configs.rust-tools")
require("configs.symbols-outline")
require("configs.toggleterm")
require("configs.treesitter")
local ok, _ = pcall(require, "google")
if not ok then
	print("failed to load google lua config")
end

vim.api.nvim_exec([[
function! SourceIfExists(file)
  if filereadable(expand(a:file))
    exe 'source' a:file
  endif
endfunction
let work_path = $XDG_CONFIG_HOME . '/nvim/google.vim'
call SourceIfExists(work_path)
]], true)


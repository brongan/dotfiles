require("globals")
require("basics")
require("plugins")
require("mappings")
require("navigation")
local ok, _ = pcall(require, "google")
if not ok then
	print("Failed to load google config")
	vim.g.copilot_assume_mapped = true
	vim.g.copilot_no_tab_map = true
end

vim.cmd([[
  augroup Gruvbox
  autocmd vimenter * ++nested colorscheme gruvbox
  augroup END
]])

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
require("configs.trouble")

vim.api.nvim_exec([[
function! SourceIfExists(file)
  if filereadable(expand(a:file))
    exe 'source' a:file
  endif
endfunction
let work_path = $XDG_CONFIG_HOME . '/nvim/google.vim'
call SourceIfExists(work_path)
]], true)


require("globals")
require("basics")
require("plugins")
require("mappings")
require("navigation")

vim.cmd("colorscheme gruvbox")

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

vim.api.nvim_exec([[
function! SourceIfExists(file)
  if filereadable(expand(a:file))
    exe 'source' a:file
  endif
endfunction
let work_path = $XDG_CONFIG_HOME . '/nvim/google.vim'
call SourceIfExists(work_path)
]], true)

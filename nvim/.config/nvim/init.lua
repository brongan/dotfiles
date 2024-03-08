require("basics")
require("plugins")
require("mappings")
local ok, _ = pcall(require, "google")
if not ok then
	print("Loaded personal config.")
else
	require("hg").setup()
	require("libp").setup()
	require("neocitc").setup()
	require('google.comments').setup()
	require('luasnip-google').load_snippets()
	print("Loaded Google config.")
end


require('catppuccin').setup({ transparent_background = true })
require("colorizer").setup({ css = { css = true } })
require("configs.bufferline")
require("ibl").setup({})
require("configs.lsp")
require("configs.nvim-cmp")
require("configs.treesitter")
require("flutter-tools").setup()
require("lsp_signature").setup()
require("nvim-ts-autotag").setup()
require("toggleterm").setup { open_mapping = [[<M-cr>]], size = 20 }
require("trouble").setup {}
require('lualine').setup()

vim.cmd.colorscheme "catppuccin-mocha"

vim.api.nvim_exec([[
function! SourceIfExists(file)
  if filereadable(expand(a:file))
    exe 'source' a:file
  endif
endfunction
let work_path = $XDG_CONFIG_HOME . '/nvim/google.vim'
call SourceIfExists(work_path)
]], true)

require("basics")
require("plugins")
require("mappings")
local ok, google = pcall(require, "google")
if ok then
	google.init()
	print("Loaded Google config.")
else
	require("lualine").setup()
	print("Loaded personal config.")
end

require("catppuccin").setup({ transparent_background = true })
require("colorizer").setup({ "*" })
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

vim.cmd.colorscheme "catppuccin-mocha"


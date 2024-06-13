require("basics")
require("plugins")
require("mappings")
if pcall(require, "google") then
	require("hg").setup()
	require("libp").setup()
	require("neocitc").setup()
	local function workspace()
		local file_path = vim.api.nvim_buf_get_name(0)
		local ws = require("neocitc").workspace_from_path(file_path)
		if not ws then return "" end
		return "[" .. ws .. "]"
	end
	require("lualine").setup {
		sections = {
			lualine_a = { "mode" },
			lualine_b = { workspace },
			lualine_c = { "filename" },
		},
	}
	require("google.comments").setup()
	require("luasnip-google").load_snippets()
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

vim.api.nvim_exec([[
function! SourceIfExists(file)
  if filereadable(expand(a:file))
    exe "source" a:file
  endif
endfunction
let work_path = $XDG_CONFIG_HOME . "/nvim/google.vim"
call SourceIfExists(work_path)
]], true)

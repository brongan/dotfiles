local lspconfig = require("lspconfig")

vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]]

-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local lsp_defaults = lspconfig.util.default_config
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local ok, _ = pcall(require, "google")
if ok then
	capabilities = require("google").init_lsp(capabilities)
end

lsp_defaults.capabilities = vim.tbl_deep_extend(
  'force',
  lsp_defaults.capabilities,
  capabilities
)

local servers = { 'pyright', 'tsserver'}
for _, lsp in pairs(servers) do
  lspconfig[lsp].setup {
    flags = {}
  }
end

lspconfig.clangd.setup {
	cmd = {
		"clangd",
		"--clang-tidy",
		"--background-index",
	},
	filetypes = {"c", "cpp", "objc", "objcpp"},
}

lspconfig.rust_analyzer.setup({
    settings = {
      ["rust-analyzer"] = {
        checkOnSave = {
          command = "clippy"
        },
      }
    }
})

vim.cmd([[
  augroup CmpZsh
    au!
    autocmd Filetype zsh lua require'cmp'.setup.buffer { sources = { { name = "zsh" }, } }
  augroup END
]])


local lsp = require('lsp-zero').preset({})
local lspconfig = require("lspconfig")
local ih = require("lsp-inlayhints")

ih.setup()

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({buffer = bufnr})
  if client.name ~= "ciderlsp" then
	  lsp.buffer_autoformat()
  end
end)

lsp.ensure_installed({
  'clangd',
  'rust_analyzer'
})

lsp.skip_server_setup({'clangd'})
require('clangd_extensions').setup()

vim.api.nvim_create_augroup("LspAttach_inlayhints", {})
vim.api.nvim_create_autocmd("LspAttach", {
  group = "LspAttach_inlayhints",
  callback = function(args)
    if not (args.data and args.data.client_id) then
      return
    end

    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    ih.on_attach(client, bufnr)
  end,
})

-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local lsp_defaults = lspconfig.util.default_config
local capabilities = require('cmp_nvim_lsp').default_capabilities()
if pcall(require, "google") then
	capabilities = require("google").init_lsp(capabilities)
end

lsp_defaults.capabilities = vim.tbl_deep_extend(
  'force',
  lsp_defaults.capabilities,
  capabilities
)

lspconfig.clangd.setup {
	cmd = {
		"clangd",
		"--clang-tidy",
		"--background-index",
	},
	filetypes = {"c", "cpp", "objc", "objcpp"},
}

vim.cmd([[
  augroup CmpZsh
    au!
    autocmd Filetype zsh lua require'cmp'.setup.buffer { sources = { { name = "zsh" }, } }
  augroup END
]])

lsp.setup()

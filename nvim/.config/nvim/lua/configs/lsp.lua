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

lsp.ensure_installed({'rust_analyzer'})
lsp.skip_server_setup({'clangd'})
require('clangd_extensions').setup()

vim.api.nvim_create_augroup("LspAttach_inlayhints", {})
vim.api.nvim_create_autocmd("LspAttach", {
  group = "LspAttach_inlayhints",
  callback = function(args)
    if not (args.data and args.data.client_id) then
      return
    end

    local client = vim.lsp.get_client_by_id(args.data.client_id)
    ih.on_attach(client, args.buf)
  end,
})

if pcall(require, "google") then
	local lsp_defaults = lspconfig.util.default_config
	lsp_defaults.capabilities = vim.tbl_deep_extend(
		'force',
		lsp_defaults.capabilities,
		require("google").init_lsp(lsp_defaults.capabilities)
	)
end

lsp.setup()

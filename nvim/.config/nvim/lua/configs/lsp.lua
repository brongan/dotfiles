local lsp_zero = require('lsp-zero').preset({})
local lspconfig = require("lspconfig")
local ih = require("lsp-inlayhints")

ih.setup()

lsp_zero.on_attach(function(_client, bufnr)
	lsp_zero.default_keymaps({ buffer = bufnr })
	local bind = vim.keymap.set
	lsp_zero.buffer_autoformat()
	local bufmap = function(mode, lhs, rhs)
		local opts = { buffer = bufnr, noremap = true }
		bind(mode, lhs, rhs, opts)
	end

	bufmap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')
	bufmap('n', '<Leader>rn', '<cmd>lua vim.lsp.buf.rename()<cr>')
	bufmap('n', '<Leader>a', '<cmd>lua vim.lsp.buf.code_action()<cr>')
	bufmap('x', '<Leader>a', '<cmd>lua vim.lsp.buf.range_code_action()<cr>')
	bufmap("n", "g0", "<cmd>lua vim.lsp.buf.document_symbol()<CR>")
	bufmap("n", "gW", "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>")
	bufmap('n', "<Leader>ld", "<cmd>TroubleToggle lsp_definitions<CR>")
	bufmap('n', "<Leader>lE", "<cmd>TroubleToggle workspace_diagnostics<CR>")
end)

lsp_zero.format_on_save({
	format_opts = {
		async = true,
		timeout_ms = 10000,
	},
})

lsp_zero.setup_servers({ 'tsserver', 'rust_analyzer' })
lsp_zero.skip_server_setup({ 'clangd' })
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
		'keep',
		lsp_defaults.capabilities,
		require("google").init_lsp(lsp_defaults.capabilities)
	)
end

lsp_zero.setup()

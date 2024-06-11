local lsp_zero = require('lsp-zero').preset({})
local lspconfig = require("lspconfig")

lsp_zero.on_attach(function(client, bufnr)
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

	vim.api.nvim_command("augroup LSP")
	vim.api.nvim_command("autocmd!")
	if client.server_capabilities.documentFormattingProvider then
		vim.api.nvim_command("autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()")
		vim.api.nvim_command("autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()")
		vim.api.nvim_command("autocmd CursorMoved <buffer> lua vim.lsp.util.buf_clear_references()")
	end
	vim.api.nvim_command("augroup END")
end)

lsp_zero.format_on_save({
	format_opts = {
		async = true,
		timeout_ms = 10000,
	},
})

lsp_zero.setup_servers({ 'tsserver', 'rust_analyzer', 'jsonls', 'lua_ls', 'glsl_analyzer', 'nil_ls', 'bufls' })

require 'lspconfig'.lua_ls.setup {
	settings = {
		Lua = {
			diagnostics = {
				globals = { 'vim' }
			}
		}
	}
}


require('clangd_extensions').setup()

if pcall(require, "google") then
	local lsp_defaults = lspconfig.util.default_config
	lsp_defaults.capabilities = vim.tbl_deep_extend(
		'keep',
		lsp_defaults.capabilities,
		require("google").init_lsp(lsp_defaults.capabilities)
	)
end

lsp_zero.setup()

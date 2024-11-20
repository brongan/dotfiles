return {
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v3.x",
		dependencies = {
			'neovim/nvim-lspconfig',
			{ 'j-hui/fidget.nvim', opts = {} }, -- Useful status updates for LSP.
		},
		config = function()
			local lsp_zero = require('lsp-zero').preset({})
			local lspconfig = require("lspconfig")

			lsp_zero.on_attach(function(client, bufnr)
				lsp_zero.default_keymaps({ buffer = bufnr })
				lsp_zero.buffer_autoformat()
				local map = function(lhs, rhs, desc)
					local opts = { buffer = bufnr, noremap = true, desc = 'LSP: ' .. desc }
					vim.keymap.set('n', lhs, rhs, opts)
				end

				map('K', vim.lsp.buf.hover, 'Hover Documentation')
				map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
				map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
				map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
				map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
				map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
				map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
				map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
				map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
				map('<leader>a', vim.lsp.buf.code_action, 'Code [A]ction')
				map('K', vim.lsp.buf.hover, 'Hover Documentation')
				map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

				if client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
					vim.lsp.inlay_hint.enable(true, { 0 })
					map('<leader>th', function()
						vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled(bufnr))
					end, '[T]oggle Inlay [H]ints')
				end

				if client.server_capabilities.documentHighlightProvider then
					local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })
					vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
						buffer = bufnr,
						group = highlight_augroup,
						callback = vim.lsp.buf.document_highlight,
					})

					vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
						buffer = bufnr,
						group = highlight_augroup,
						callback = vim.lsp.buf.clear_references,
					})

					vim.api.nvim_create_autocmd('LspDetach', {
						group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
						callback = function(event2)
							vim.lsp.buf.clear_references()
							vim.api.nvim_clear_autocmds { group = 'lsp-highlight', buffer = event2.buf }
						end,
					})
				end
			end)

			lsp_zero.format_on_save({
				format_opts = {
					async = true,
					timeout_ms = 10000,
				},
			})

			lsp_zero.setup_servers({ 'ts_ls', 'rust_analyzer', 'jsonls', 'lua_ls', 'nil_ls', 'buf_ls' })
			require 'lspconfig'.lua_ls.setup {
				settings = {
					Lua = {
						runtime = { version = 'LuaJIT' },
						workspace = {
							checkThirdParty = false,
							library = vim.api.nvim_get_runtime_file('', true),
						},
						diagnostics = {
							globals = { 'vim' }
						}
					}
				}
			}
			local ok, google = pcall(require, "google")
			if ok then
				local lsp_defaults = lspconfig.util.default_config
				lsp_defaults.capabilities = vim.tbl_deep_extend(
					'keep',
					lsp_defaults.capabilities,
					google.init_lsp(lsp_defaults.capabilities)
				)
			end
			lsp_zero.setup()
		end
	},

}

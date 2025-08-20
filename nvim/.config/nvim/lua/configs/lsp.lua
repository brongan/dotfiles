return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "j-hui/fidget.nvim", opts = {} }, -- Useful status updates for LSP.
		},
		config = function()
			local lspconfig = require("lspconfig")

			-- Function to configure LSP settings
			local function on_attach(client, bufnr)
				local map = function(lhs, rhs, desc)
					local opts = { buffer = bufnr, noremap = true, desc = "LSP: " .. desc }
					vim.keymap.set("n", lhs, rhs, opts)
				end

				map("K", vim.lsp.buf.hover, "Hover Documentation")
				map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
				map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
				map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
				map("gi", require("telescope.builtin").lsp_implementations, "[G]oto [i]mplementation")
				map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
				map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
				map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
				map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
				map("<leader>a", vim.lsp.buf.code_action, "Code [A]ction")

				local filetype = vim.bo[bufnr].filetype
				local normal = filetype ~= "bzl" and filetype ~= "proto"

				if client.server_capabilities.documentHighlightProvider and normal then
					local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
						buffer = bufnr,
						group = highlight_augroup,
						callback = vim.lsp.buf.document_highlight,
					})

					vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
						buffer = bufnr,
						group = highlight_augroup,
						callback = vim.lsp.buf.clear_references,
					})

					vim.api.nvim_create_autocmd("LspDetach", {
						group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
						callback = function(event2)
							vim.lsp.buf.clear_references()
							vim.api.nvim_clear_autocmds({ group = "lsp-highlight", buffer = event2.buf })
						end,
					})
				end

				if client:supports_method("textDocument/inlayHint") or client.server_capabilities.inlayHintProvider then
					vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
					map("<leader>th", function()
						vim.lsp.inlay_hint.enable(
							not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }),
							{ bufnr = bufnr }
						)
					end, "[T]oggle Inlay [H]ints")
				end

				if vim.lsp.codelens then
					vim.lsp.codelens.refresh()
					vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
						buffer = bufnr,
						callback = vim.lsp.codelens.refresh,
					})
				end
			end

			-- Create an autocommand for LspAttach
			vim.api.nvim_create_autocmd("LspAttach", {
				desc = "LSP actions",
				callback = function(args)
					local client = vim.lsp.get_client_by_id(args.data.client_id)
					local bufnr = args.buf
					on_attach(client, bufnr)
				end,
			})

			vim.lsp.config["lua_ls"] = {
				settings = {
					Lua = {
						runtime = { version = "LuaJIT" },
						workspace = {
							checkThirdParty = false,
							library = vim.api.nvim_get_runtime_file("", true),
						},
						diagnostics = {
							globals = { "vim" },
						},
					},
				},
			}

			vim.lsp.enable("clangd")
			vim.lsp.enable("gopls")
			vim.lsp.enable("rust_analyzer")
			vim.lsp.enable("pyright")
			vim.lsp.enable("lua_ls")

			local ok, google = pcall(require, "google")
			if ok then
				local lsp_defaults = lspconfig.util.default_config
				lsp_defaults.capabilities =
					vim.tbl_deep_extend("keep", lsp_defaults.capabilities, google.init_lsp(lsp_defaults.capabilities))
			end
		end,
	},
}

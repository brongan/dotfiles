return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"j-hui/fidget.nvim",
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			require("fidget").setup({})

			local defaults = vim.lsp.config["*"] or {}
			local capabilities = vim.tbl_deep_extend(
				"force",
				defaults.capabilities or vim.lsp.protocol.make_client_capabilities(),
				require("cmp_nvim_lsp").default_capabilities()
			)

			vim.lsp.config["*"] = { capabilities = capabilities }

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc)
						vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end

					map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
					map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
					map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
					map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
					map("<leader>a", vim.lsp.buf.code_action, "Code [A]ction")
					map("K", vim.lsp.buf.hover, "Hover Documentation")

					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
						map("<leader>th", function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }),
								{ bufnr = event.buf })
						end, "[T]oggle Inlay [H]ints")
					end
				end,
			})

			local ok, google = pcall(require, "google")

			if ok and google.init_lsp then
				google.init_lsp(capabilities)
			else
				vim.lsp.config["lua_ls"] = {
					settings = {
						Lua = {
							runtime = { version = "LuaJIT" },
							workspace = { checkThirdParty = false },
							diagnostics = { globals = { "vim" } },
						},
					},
				}

				local servers = { "clangd", "gopls", "rust_analyzer", "pyright", "taplo", "lua_ls", "ts_ls" }

				for _, server in ipairs(servers) do
					vim.lsp.enable(server)
				end
			end
		end,
	},
}

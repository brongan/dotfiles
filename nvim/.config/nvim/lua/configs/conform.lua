return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>s",
			function()
				require("conform").format({ async = true, lsp_fallback = true })
			end,
			mode = { "n", "v" },
			desc = "Format buffer",
		},
	},
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },

			-- Web Stack: Use prettierd if available, fallback to prettier
			javascript = { "prettierd", "prettier", stop_after_first = true },
			typescript = { "prettierd", "prettier", stop_after_first = true },
			javascriptreact = { "prettierd", "prettier", stop_after_first = true },
			typescriptreact = { "prettierd", "prettier", stop_after_first = true },
			css = { "prettierd", "prettier", stop_after_first = true },
			html = { "prettierd", "prettier", stop_after_first = true },
			json = { "prettierd", "prettier", stop_after_first = true },
			yaml = { "prettierd", "prettier", stop_after_first = true },
			markdown = { "prettierd", "prettier", stop_after_first = true },

			nix = { "alejandra", "nixfmt", stop_after_first = true },

			rust = { "rustfmt", lsp_format = "fallback" },

			-- Python
			python = { "isort", "black" },

			-- Shell
			bash = { "shfmt" },
			sh = { "shfmt" },
			zsh = { "shfmt" },
		},

		-- Default options
		default_format_opts = {
			lsp_format = "fallback",
		},

		format_on_save = { timeout_ms = 2500, lsp_fallback = true },

		formatters = {
			prettier = {
				prepend_args = { "--use-tabs", "--tab-width", "4" },
			},
			shfmt = {
				prepend_args = { "-i", "4" },
			},
		},
	},
	init = function()
		vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
	end,
}

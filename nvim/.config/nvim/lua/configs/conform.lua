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

			javascript = { "dprint" },
			typescript = { "dprint" },
			javascriptreact = { "dprint" },
			typescriptreact = { "dprint" },
			css = { "dprint" },
			html = { "dprint" },
			json = { "dprint" },
			yaml = { "dprint" },
			markdown = { "dprint" },
			toml = { "taplo" },

			nix = { "alejandra", "nixfmt", stop_after_first = true },

			rust = { "rustfmt", lsp_format = "fallback" },

			python = { "ruff_organize_imports", "ruff_format" },

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
			shfmt = {
				prepend_args = { "-i", "4" },
			},
		},
	},
	init = function()
		vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
	end,
}

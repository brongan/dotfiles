require("nvim-treesitter")

require'nvim-treesitter.configs'.setup {
	ts_funky_keywords = { enable = true },
	ensure_installed = "all",
	highlight = {
		enable = true,
	},
	playground = {
		enable = true,
		disable = {},
		updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "gnn",
			node_incremental = "grc",
			scope_incremental = "gmc",
			node_decremental = "grm",
		},
	},
	query_linter = {
		enable = true,
		use_virtual_text = true,
		lint_events = { "BufWrite", "CursorHold" },
	},
	context_commentstring = { enable = true },

	refactor = {
		highlight_definition = { enable = true },
		navigation = { enable = true },
	},
	textobjects = { enable = true },
}


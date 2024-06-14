return {
	{ -- Highlight, edit, and navigate code
		'nvim-treesitter/nvim-treesitter',
		build = ':TSUpdate',
		config = function()
			require 'nvim-treesitter.configs'.setup {
				ensure_installed = { "c", "vim", "vimdoc", "query", "rust", "cpp", "proto", "bash", "diff", "html", "lua", "luadoc", "markdown", },
				sync_install = false,
				auto_install = false,
				highlight = {
					enable = true,
				},
				ignore_install = {},
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
				modules = {},
			}
		end
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		config = function()
			require 'treesitter-context'.setup {
				enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
				max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
				min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
				line_numbers = true,
				multiline_threshold = 20, -- Maximum number of lines to collapse for a single context line
				trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
				mode = 'cursor', -- Line used to calculate context. Choices: 'cursor', 'topline'
				-- Separator between context and content. Should be a single character string, like '-'.
				-- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
				separator = nil,
				zindex = 20, -- The Z-index of the context window
			}

			vim.filetype.add({
				pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
			})
		end
	}, -- Shows context of visible buffer contents.
}

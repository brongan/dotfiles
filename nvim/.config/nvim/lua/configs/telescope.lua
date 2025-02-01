local map = vim.keymap.set;
return { -- Fuzzy Finder (files, lsp, etc)
	'nvim-telescope/telescope.nvim',
	event = 'VimEnter',
	branch = '0.1.x',
	dependencies = {
		'nvim-lua/plenary.nvim',
		'nvim-telescope/telescope-fzf-native.nvim',
		'nvim-telescope/telescope-ui-select.nvim',
		{ 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
	},
	config = function()
		require('telescope').setup {
			defaults = {
				layout_config = {
					horizontal = { width = 0.90 }
				},
				mappings = {
					i = {
						["<C-h>"] = "which_key",
					}
				}
			},
			extensions = {
				['ui-select'] = {
					require('telescope.themes').get_dropdown(),
				},
			},
		}

		-- Enable Telescope extensions if they are installed
		pcall(require('telescope').load_extension, 'fzf')
		pcall(require('telescope').load_extension, 'ui-select')

		-- See `:help telescope.builtin`
		local builtin = require 'telescope.builtin'
		map('n', '<leader>fh', builtin.help_tags, { desc = '[f]uzzy [h]elp' })
		map('n', '<leader>fk', builtin.keymaps, { desc = '[f]uzzy [k]eymaps' })
		map('n', '<leader>ff', builtin.find_files, { desc = '[f]uzzy [f]iles' })
		map('n', '<leader>fs', builtin.git_status, { desc = '[f]uzzy git [s]tatus' })
		map('n', '<leader>fg', builtin.git_files, { desc = '[f]uzzy [g]it ls-files' })
		map('n', '<leader>fd', builtin.diagnostics, { desc = '[f]uzzy [dj]iagnostics' })
		map('n', '<leader>fr', builtin.resume, { desc = '[f]uzzy [r]esume' })
		map('n', '<leader>fq', builtin.quickfix, { desc = '[f]uzzy [qj]uickfix' })
		map('n', '<leader>f.', builtin.oldfiles, { desc = '[f]uzzy Recent Files ("." for repeat)' })
		map('n', '<leader>fb', builtin.buffers, { desc = '[f] existing [b]uffers' })
		map('n', '<leader>fB', builtin.live_grep, { desc = '[f]uzzy lines in [B]uffer' })
		map('n', '<leader>fc', builtin.commands, { desc = '[f]uzzy [c]ommands' })
		map('n', '<leader>f/', builtin.search_history, { desc = '[f]uzzy [s]earch [h]istory' })
		map('n', '<leader>f:', builtin.command_history, { desc = '[f]uzzy command history' })

		local grep_files = function()
			builtin.live_grep {
				grep_open_files = true,
				prompt_title = 'Live Grep in Open Files',
			}
		end
		map('n', '<leader>fl', grep_files, { desc = '[f]uzzy [l]ines' })
	end,
}

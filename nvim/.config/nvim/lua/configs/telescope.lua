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
		map('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
		map('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
		map('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
		map('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
		map('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
		map('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
		map('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
		map('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
		map('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
		map('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

		local grep_files = function()
			builtin.live_grep {
				grep_open_files = true,
				prompt_title = 'Live Grep in Open Files',
			}
		end
		map('n', '<leader>fl', grep_files, { desc = '[F]uzzy [l]ines' })
		map('n', '<leader>s/', grep_files, { desc = '[S]earch [/] in Open Files' })
	end,
}

local cmp = require("cmp")
local cmp_action = require('lsp-zero').cmp_action()
local lspkind = require("lspkind")
local luasnip = require("luasnip")

local kind_icons = {
	Class = " ",
	Color = " ",
	Constant = "ﲀ ",
	Constructor = " ",
	Enum = "練",
	EnumMember = " ",
	Event = " ",
	Field = " ",
	File = "",
	Folder = " ",
	Function = " ",
	Interface = "ﰮ ",
	Keyword = " ",
	Method = " ",
	Module = " ",
	Operator = "",
	Property = " ",
	Reference = " ",
	Snippet = " ",
	Struct = " ",
	Text = " ",
	TypeParameter = " ",
	Unit = "塞",
	Value = " ",
	Variable = " ",
}

local source_names = {
	luasnip = "(✂)",
	nvim_ciderlsp = "(🤖)",
	buganizer = "(🐛)",
	nvim_lsp = "(🔧)",
	emoji = "(💩)",
	path = "(🛣️)",
	nvim_lua = "(CMP)",
	buffer = "(🗏)",
	tmux = "(TMUX)",
}

local duplicates = {
	buffer = 1,
	path = 1,
	nvim_lsp = 0,
	luasnip = 1,
}

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	sources = cmp.config.sources({
		{ name = 'luasnip' },
		{ name = 'nvim_ciderlsp' },
		{ name = 'buganizer' },
		{ name = 'nvim_lsp' },
		{ name = 'nvim_lua' },
		{ name = 'buffer',       keyword_length = 5 },
		{ name = 'path' },
		{ name = 'tmux' },
		{ name = 'emoji' },
	}),
	sorting = {
		priority_weight = 2,
		comparators = {
			cmp.config.compare.offset,
			cmp.config.compare.exact,
			cmp.config.compare.score,
			cmp.config.compare.recently_used,
			cmp.config.compare.locality,
			cmp.config.compare.kind,
			cmp.config.compare.sort_text,
			cmp.config.compare.length,
			cmp.config.compare.order,
		},
	},
	formatting = {
		fields = { "kind", "abbr", "menu" },
		format = lspkind.cmp_format({
			with_text = true,
			maxwidth = 40, -- half max width
			before = function(entry, vim_item)
				vim_item.kind = kind_icons[vim_item.kind]
				vim_item.menu = source_names[entry.source.name]
				vim_item.dup = duplicates[entry.source.name]
				return vim_item
			end
		}),
	},
	mapping = cmp.mapping.preset.insert {
		-- Select the [n]ext item
		['<C-n>'] = cmp.mapping.select_next_item(),
		-- Select the [p]revious item
		['<C-p>'] = cmp.mapping.select_prev_item(),

		-- Scroll the documentation window [b]ack / [f]orward
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),

		-- Accept ([y]es) the completion.
		--  This will auto-import if your LSP supports it.
		--  This will expand snippets if the LSP sent a snippet.
		['<C-y>'] = cmp.mapping.confirm { select = true },

		-- If you prefer more traditional completion keymaps,
		-- you can uncomment the following lines
		--['<CR>'] = cmp.mapping.confirm { select = true },
		--['<Tab>'] = cmp.mapping.select_next_item(),
		--['<S-Tab>'] = cmp.mapping.select_prev_item(),

		-- Manually trigger a completion from nvim-cmp.
		--  Generally you don't need this, because nvim-cmp will display
		--  completions whenever it has completion options available.
		['<C-Space>'] = cmp.mapping.complete {},

		-- Think of <c-l> as moving to the right of your snippet expansion.
		--  So if you have a snippet that's like:
		--  function $name($args)
		--    $body
		--  end
		--
		-- <c-l> will move you to the right of each of the expansion locations.
		-- <c-h> is similar, except moving you backwards.
		['<C-l>'] = cmp.mapping(function()
			if luasnip.expand_or_locally_jumpable() then
				luasnip.expand_or_jump()
			end
		end, { 'i', 's' }),
		['<C-h>'] = cmp.mapping(function()
			if luasnip.locally_jumpable(-1) then
				luasnip.jump(-1)
			end
		end, { 'i', 's' }),

		-- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
		--    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
	},
	experimental = {
		native_menu = false,
		ghost_text = true,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	}
})

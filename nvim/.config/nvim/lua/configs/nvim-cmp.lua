local cmp = require("cmp")
local lspkind = require("lspkind")

local source_names = {
	nvim_lsp = "(LSP)",
	emoji = "(Emoji)",
	path = "(Path)",
	calc = "(Calc)",
	cmp_tabnine = "(Tabnine)",
	vsnip = "(Snippet)",
	luasnip = "(Snippet)",
	buffer = "(Buffer)",
	tmux = "(TMUX)",
}

cmp.setup({
	sources = cmp.config.sources(source_names),
	formatting = {
		format = lspkind.cmp_format({
			with_text = true,
			maxwidth = 40, -- half max width
			menu = {
				buffer = "[buffer]",
				nvim_lsp = "[LSP]",
				nvim_lua = "[API]",
				path = "[path]",
				vim_vsnip = "[snip]",
			},
		}),
	},
	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-u>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.close(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<Tab>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "s" }),
	}),	
	experimental = {
		native_menu = false,
		ghost_text = true,
	},
})


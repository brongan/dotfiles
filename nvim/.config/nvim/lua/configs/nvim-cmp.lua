vim.opt.completeopt = { "menu", "menuone", "noselect", "noinsert" }

return {
	{
		"saadparwaiz1/cmp_luasnip",
		dependencies = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			"onsails/lspkind.nvim", -- LSP Symbols
			"hrsh7th/cmp-path",
			"hrsh7th/nvim-cmp", -- Autocompletion
			{ "L3MON4D3/LuaSnip", dependencies = { "rafamadriz/friendly-snippets" }, },
		},
		config = function()
			local cmp = require("cmp")
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
				nvim_lua = "()",
				buffer = "(🗏)",
				tmux = "()",
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
					['<C-Space>'] = cmp.mapping.complete {},
					['<C-y>'] = cmp.mapping.confirm { select = true },
					["<CR>"] = cmp.mapping.confirm({ select = false }),
					-- https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#super-tab-like-mapping
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.locally_jumpable(1) then
							luasnip.jump(1)
						elseif has_words_before() then
							cmp.complete()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),

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
				},
				experimental = {
					ghost_text = true,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				}
			})
		end
	}
}

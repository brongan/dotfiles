"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => nvim-treesitter
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
lua << EOF
require'nvim-treesitter.configs'.setup {
ensure_installed = "all",     -- one of "all", "language", or a list of languages
highlight = {
enable = true,              -- false will disable the whole extension
},
   incremental_selection = {
   enable = true,
   keymaps = {
       init_selection = "gnn",
       node_incremental = "grn",
       scope_incremental = "grc",
       node_decremental = "grm",
       },
   },
   refactor = {
       highlight_definition = { enable = true },
       navigation = { enable = true },
       },
   textobjects = { enable = true },
   }
EOF

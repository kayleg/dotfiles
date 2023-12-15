local map = vim.api.nvim_set_keymap
map('n', ';', '', {})
vim.g.mapleader = ';'
vim.g.maplocalleader = ';'

-- Quick close current buffer
map('n', '<leader>q', '<cmd>b#|bd#<cr>', { noremap = true })

-- Shortcuts for search
map('n', '<leader>ff', '<cmd>lua require("telescope.builtin").find_files()<cr>', { noremap = true })
map('n', '<leader>fg', '<cmd>lua require("telescope.builtin").live_grep()<cr>', { noremap = true })
map('n', '<leader>fb', '<cmd>lua require("telescope.builtin").buffers()<cr>', { noremap = true })
map('n', '<leader>fh', '<cmd>lua require("telescope.builtin").help_tags()<cr>', { noremap = true })
map('n', '<leader>fw', '<cmd>lua require("telescope.builtin").grep_string()<cr>', { noremap = true })
map('n', '<leader>fr', '<cmd>lua require("telescope.builtin").resume()<cr>', { noremap = true })
map('n', '<leader>sc', '<cmd>noh<cr>', {})

-- Use vinegar style directory navigation
-- map('n', '-', '<cmd>lua require("nvim-tree").open_replacing_current_buffer()<cr>', {})
-- map('n', '<leader>fo', '<cmd>NvimTreeFindFileToggle<cr>', {})
map('n', '<leader>fo', '<cmd>Neotree filesystem reveal<cr>', {})

-- Set shortcuts for switching open buffers
map('n', '<leader>1', '<cmd>BufferLineGoToBuffer 1<CR>', { silent = true })
map('n', '<leader>2', '<cmd>BufferLineGoToBuffer 2<CR>', { silent = true })
map('n', '<leader>3', '<cmd>BufferLineGoToBuffer 3<CR>', { silent = true })
map('n', '<leader>4', '<cmd>BufferLineGoToBuffer 4<CR>', { silent = true })
map('n', '<leader>5', '<cmd>BufferLineGoToBuffer 5<CR>', { silent = true })
map('n', '<leader>6', '<cmd>BufferLineGoToBuffer 6<CR>', { silent = true })
map('n', '<leader>7', '<cmd>BufferLineGoToBuffer 7<CR>', { silent = true })
map('n', '<leader>8', '<cmd>BufferLineGoToBuffer 8<CR>', { silent = true })
map('n', '<leader>9', '<cmd>BufferLineGoToBuffer 9<CR>', { silent = true })
map('n', '<leader>$', '<cmd>BufferLineGoToBuffer -1<CR>', { silent = true })

-- Git
map('n', '<leader>gs', '<cmd>Neogit<cr>', {})

-- Clipboard
map('v', '<leader>y', '"+y', {})
map('n', '<leader>yy', '"+yy', {})
map('n', '<leader>p', '"+p', {})
map('n', '<leader>P', '"+P', {})
map('n', '<leader>cp', ':let @+=expand("%")<CR>', {})     -- relative path (src/foo.txt)
map('n', '<leader>cP', ':let @+=expand("%:p")<CR>', {})   -- absolute path (/something/src/foo.txt)
map('n', '<leader>cf', ':let @+=expand("%:t")<CR>', {})   -- filename (foo.txt)
map('n', '<leader>cd', ':let @+=expand("%:p:h")<CR>', {}) -- directory name (/something/src)

-- LSP
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<leader>ee', '<cmd>Trouble<cr>', opts)
vim.keymap.set(
  "n",
  "<Leader>el",
  '<cmd>lua require("lsp_lines").toggle()<CR>',
  { desc = "Toggle lsp_lines" }
)

-- Glance
vim.keymap.set('n', 'gD', '<CMD>Glance definitions<CR>', opts)
vim.keymap.set('n', 'gR', '<CMD>Glance references<CR>', opts)
vim.keymap.set('n', 'gT', '<CMD>Glance type_definitions<CR>', opts)
vim.keymap.set('n', 'gM', '<CMD>Glance implementations<CR>', opts)

-- Tests
map('n', '<leader>tt', '<cmd>lua require("neotest").run.run()<cr>', { noremap = true })
map('n', '<leader>tf', '<cmd>lua require("neotest").run.run(vim.fn.expand("%"))<cr>', { noremap = true })
map('n', '<leader>ts', '<cmd>lua require("neotest").run.run(vim.fn.getcwd())<cr>', { noremap = true })
map('n', '<leader>tl', '<cmd>lua require("neotest").run.run_last()<cr>', { noremap = true })
map('n', '<leader>tr', '<cmd>lua require("neotest").summary.open()<cr>', { noremap = true })
map('n', '<leader>tm', '<cmd>lua require("neotest").summary.run_marked()<cr>', { noremap = true })
map('n', '<leader>tc', '<cmd>lua require("coverage").load();require("coverage").show()<cr>', { noremap = true })
map('n', '<leader>tcs', '<cmd>lua require("coverage").load();require("coverage").summary();vim.opt.winblend=0<cr>',
  { noremap = true })

-- Other
map('n', '<leader>sw', '<cmd>Other<cr>', { noremap = true })

-- Task Runner
map('n', '<leader>r', '<cmd>OverseerRun<cr>', { noremap = true })
map('n', '<leader>o', '<cmd>OverseerOpen<cr>', { noremap = true })

-- Open symbol outline
vim.keymap.set('n', '<leader>so', '<CMD>SymbolsOutline<CR>', opts)

-- Make Editing Compiled Files Faster
map('n', '<leader>xx', '<cmd>TSDisable highlight <bar> IndentBlanklineDisable <cr>', { noremap = true })

-- Neorg
vim.keymap.set('n', '<leader>no', '<CMD>Neorg index<CR>', opts)

-- Navigation
map('n', '<leader>w', '<CMD>:lua require("nvim-window").pick()<CR>', opts)

-- remap to open the Telescope refactoring menu in visual mode
vim.api.nvim_set_keymap(
  "v",
  "<leader>rr",
  "<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>",
  { noremap = true }
)

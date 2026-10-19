-- Git UI: Neogit (magit-style) + Diffview. (mine, not upstream)
-- Installed but unused by nothing: gitsigns covers gutter signs (lua/plugins/gitsigns.lua),
-- this covers the "open a panel and drive the index" workflow.

local pack = require 'config.pack'

vim.pack.add {
  pack.gh 'NeogitOrg/neogit',
  pack.gh 'sindrets/diffview.nvim', -- optional, but Neogit uses it for richer diffs
}

require('neogit').setup {}

vim.keymap.set('n', '<leader>g', '<cmd>Neogit<CR>', { desc = 'Open Neogit status' })
vim.keymap.set('n', '<leader>gd', '<cmd>DiffviewOpen<CR>', { desc = 'Open [D]iffview' })
vim.keymap.set('n', '<leader>gh', '<cmd>DiffviewFileHistory %<CR>', { desc = 'File [h]istory in Diffview' })

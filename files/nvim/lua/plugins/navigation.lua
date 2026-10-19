-- File explorer + seamless vim/tmux window navigation. (mine, not upstream)
-- vim-tmux-navigator pairs with the tpm plugin already in files/tmux/tmux.conf.

local pack = require 'config.pack'

-- [[ nvim-tree.lua ]] file tree, pinned to the right so text stays centred.
vim.pack.add { pack.gh 'nvim-tree/nvim-tree.lua' }

require('nvim-tree').setup {
  view = {
    width = 30,
    side = 'right',
    preserve_window_proportions = true,
  },
  renderer = {
    group_empty = true,
    highlight_git = true,
  },
  filters = {
    dotfiles = false,
  },
  git = {
    enable = true,
    ignore = false,
  },
  update_focused_file = {
    enable = true,
    update_cwd = true,
  },
  actions = {
    open_file = {
      quit_on_open = true,
    },
  },
}

vim.keymap.set('n', '<leader>e', '<cmd>NvimTreeToggle<CR>', { desc = 'Toggle file explorer' })

-- [[ vim-tmux-navigator ]] <C-h/j/k/l> walks out of Neovim into tmux panes.
vim.pack.add { pack.gh 'christoomey/vim-tmux-navigator' }

-- Basic keymaps + diagnostic presentation. Upstream: kickstart "SECTION 2: KEYMAPS & AUTOCMDS".

-- [[ Basic Keymaps ]]  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode. `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic Config & Keymaps.  See `:help vim.diagnostic.Opts`
vim.diagnostic.config {
  update_in_insert = false,
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  underline = { severity = { min = vim.diagnostic.severity.WARN } },

  -- Can switch between these as you prefer:
  virtual_text = true, -- Text shows up at the end of the line
  virtual_lines = false, -- Text shows up underneath the line, with virtual lines

  -- Auto open the float, so you can read the error right after jumping with `[d` / `]d`
  jump = {
    on_jump = function(_, bufnr)
      vim.diagnostic.open_float {
        bufnr = bufnr,
        scope = 'cursor',
        focus = false,
      }
    end,
  },
}

vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit the builtin terminal with a shortcut that is easier to discover than <C-\><C-n>.
-- NOTE: won't work in all terminals/tmux; fall back to <C-\><C-n>.
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Keybinds to make split navigation easier (`:help wincmd` for the full list).
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- NOTE: Some terminals have colliding keymaps or cannot send distinct keycodes.
-- vim.keymap.set('n', '<C-S-h>', '<C-w>H', { desc = 'Move window to the left' })
-- vim.keymap.set('n', '<C-S-l>', '<C-w>L', { desc = 'Move window to the right' })
-- vim.keymap.set('n', '<C-S-j>', '<C-w>J', { desc = 'Move window to the lower' })
-- vim.keymap.set('n', '<C-S-k>', '<C-w>K', { desc = 'Move window to the upper' })

-- ============================================================
-- MY TWEAKS
-- ============================================================

-- Tabs. `<leader>t` is upstream's "[T]oggle" group; these are the tab sub-keys.
vim.keymap.set('n', '<leader>tn', '<cmd>tabnew<CR>', { desc = 'New tab' })
vim.keymap.set('n', '<leader>tc', '<cmd>tabclose<CR>', { desc = 'Close tab' })
vim.keymap.set('n', '<leader>to', '<cmd>tabonly<CR>', { desc = 'Close other tabs' })
vim.keymap.set('n', '<leader><Tab>', '<cmd>tabnext<CR>', { desc = 'Next tab' })
vim.keymap.set('n', '<leader><S-Tab>', '<cmd>tabprevious<CR>', { desc = 'Previous tab' })

-- jj as Escape (I never reach for the Esc key).
vim.keymap.set('i', 'jj', '<Esc>', { silent = true })

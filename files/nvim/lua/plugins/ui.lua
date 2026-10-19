-- Core UX plugins: indentation guesses, which-key, comment TODOs, mini modules.
-- Upstream: kickstart "SECTION 4: UI / CORE UX PLUGINS" (minus gitsigns → plugins/gitsigns.lua).

local pack = require 'config.pack'

-- Detect tabstop and shiftwidth automatically.
vim.pack.add { pack.gh 'NMAC427/guess-indent.nvim' }
require('guess-indent').setup {}

-- Shows you pending keybinds.
vim.pack.add { pack.gh 'folke/which-key.nvim' }
require('which-key').setup {
  -- Delay between pressing a key and opening which-key (ms); independent of vim.o.timeoutlen
  delay = 0,
  icons = { mappings = vim.g.have_nerd_font },
  -- Document existing key chains
  spec = {
    { '<leader>s', group = '[S]earch', mode = { 'n', 'v' } },
    { '<leader>t', group = '[T]oggle' },
    { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } }, -- needs gitsigns on_attach keymaps
    { 'gr', group = 'LSP Actions', mode = { 'n' } },
    { '<leader>e', group = '[E]xplorer' },
    { '<leader>g', group = '[G]it (Neogit)' },
    { '<leader>m', group = '[M]arkdown' },
    -- my tab keys live under the [T]oggle group
    { '<leader>tn', group = '[N]ew tab' },
    { '<leader>tc', group = '[C]lose tab' },
    { '<leader>to', group = 'Close [O]ther tabs' },
  },
}

-- Highlight todo, notes, etc. in comments.
vim.pack.add { pack.gh 'folke/todo-comments.nvim' }
require('todo-comments').setup { signs = false }

-- [[ mini.nvim ]] a collection of small, independent modules.
vim.pack.add { pack.gh 'nvim-mini/mini.nvim' }

-- Icons, if a Nerd Font is available.
if vim.g.have_nerd_font then
  require('mini.icons').setup()
  -- Backwards-compat shim for plugins that still require `nvim-web-devicons` (e.g. telescope).
  MiniIcons.mock_nvim_web_devicons()
end

-- Better Around/Inside textobjects: `va)` yank-around-paren, `ci'` change-inside-quote.
require('mini.ai').setup {
  -- NOTE: avoid the built-in incremental-selection mappings on Neovim >= 0.12
  mappings = { around_next = 'aa', inside_next = 'ii' },
  n_lines = 500,
}

-- Add/delete/replace surroundings: `saiw)`, `sd'`, `sr)'`.
require('mini.surround').setup()

-- Simple statusline. Swap this out for a statusline plugin if you prefer.
local statusline = require 'mini.statusline'
statusline.setup { use_icons = vim.g.have_nerd_font }

---@diagnostic disable-next-line: duplicate-set-field
statusline.section_location = function() return '%2l:%-2v' end

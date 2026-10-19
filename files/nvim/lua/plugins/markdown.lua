-- Markdown writing experience. (mine, not upstream) — this is the tuning file.
--
-- render-markdown.nvim renders markdown *inside* the buffer via extmarks + concealing.
-- Two things are worth knowing before editing this file, because both bit me before:
--
--   1. `render_modes` takes VIM MODES (`:h mode()`): 'n' normal, 'i' insert, 'v' visual,
--      '\22' visual-block, 'c' command, 't' terminal — or `true` for all modes.
--      An invalid string there does not error; the plugin loads and renders nothing.
--   2. `heading` (singular), and `checkbox.checked.icon` (not `checkbox.checked = '☑'`).
--      Wrong types are silently dropped by the plugin's schema; `:RenderMarkdown config`
--      prints the non-default values actually in effect, and `:checkhealth render-markdown`
--      reports invalid config. Check both after changing anything here.
--
-- Live toggles: <leader>mt toggle, <leader>me enable, <leader>md disable, <leader>mc config.

local pack = require 'config.pack'

vim.pack.add { pack.gh 'MeanderingProgrammer/render-markdown.nvim' }

require('render-markdown').setup {
  -- 'obsidian' renders in every mode (live-preview feel). Set to 'none' and drop
  -- render_modes to get upstream's default: rendered in normal/command/terminal,
  -- raw markdown the moment you press `i`.
  preset = 'obsidian',

  -- Restart the treesitter highlighter on first attach; without it the first markdown
  -- buffer of a session can come up with no highlighting.
  restart_highlighter = true,

  -- Code blocks: no sign-column noise, background spans the window, padded.
  code = {
    sign = false,
    width = 'block',
    right_pad = 1,
  },

  -- Headings: drop the `┄┄┄` sign overlay, keep the Nerd Font icons + colour ramp.
  heading = {
    sign = false,
  },

  -- Bullets: plain geometric glyphs instead of Nerd Font icons.
  bullet = {
    icons = { '•', '◦', '▪', '‣', '▫' },
  },

  checkbox = {
    unchecked = { icon = '☐ ' },
    checked = { icon = '☑ ', scope_highlight = '@markup.strikethrough' },
    custom = {
      doing = { raw = '[_]', rendered = '◐ ', highlight = 'RenderMarkdownTodo' },
    },
  },

  -- `---` rules span the window instead of the default 20 cells.
  dash = { width = 80 },

  -- Pipe tables get rounded box-drawing borders and stay aligned while typing.
  pipe_table = { preset = 'round' },

  -- Math is off unless you need it: pulls in the latex rendering pipeline per buffer.
  latex = { enabled = false },
}

-- Keymaps for the render state.
vim.keymap.set('n', '<leader>mt', '<cmd>RenderMarkdown toggle<CR>', { desc = '[M]arkdown render [t]oggle' })
vim.keymap.set('n', '<leader>me', '<cmd>RenderMarkdown enable<CR>', { desc = '[M]arkdown render [e]nable' })
vim.keymap.set('n', '<leader>md', '<cmd>RenderMarkdown disable<CR>', { desc = '[M]arkdown render [d]isable' })
vim.keymap.set('n', '<leader>mc', '<cmd>RenderMarkdown config<CR>', { desc = '[M]arkdown show effective config' })

-- Automatic bullet / numbered-list continuation in markdown and plain text.
vim.pack.add { pack.gh 'dkarter/bullets.vim' }

-- Read EPUBs in-buffer.
vim.pack.add { pack.gh 'CrystalDime/epub.nvim' }
require('epub').setup {}

-- `:Glow` renders the current file through the glow CLI (only if it is installed).
if vim.fn.executable 'glow' == 1 then
  vim.pack.add { pack.gh 'ellisonleao/glow.nvim' }
  require('glow').setup {}
end

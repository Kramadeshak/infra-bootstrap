-- Autocompletion + snippets. Upstream: kickstart "SECTION 8: AUTOCOMPLETE & SNIPPETS".

local pack = require 'config.pack'

-- [[ Snippet Engine ]]
-- Version ranges come from git tags: `:help vim.version.range()`
vim.pack.add { { src = pack.gh 'L3MON4D3/LuaSnip', version = vim.version.range '2.*' } }
require('luasnip').setup {}

-- Pre-made snippets:
-- vim.pack.add { pack.gh 'rafamadriz/friendly-snippets' }
-- require('luasnip.loaders.from_vscode').lazy_load()

-- [[ Autocomplete Engine ]]
vim.pack.add { { src = pack.gh 'saghen/blink.cmp', version = vim.version.range '1.*' } }

---@module 'blink.cmp'
---@type blink.cmp.Config
require('blink.cmp').setup {
  keymap = {
    -- 'default' (recommended): mappings like built-in completion (<c-y> accepts, expands snippets).
    -- Alternatives: 'super-tab' (Tab accepts), 'enter', 'none'.
    -- Seriously, read `:help ins-completion` before changing this.
    -- All presets keep: <tab>/<s-tab> snippet hops, <c-space> menu/docs,
    -- <c-n>/<c-p> select, <c-e> hide, <c-k> signature help.
    preset = 'default',
  },

  appearance = {
    -- 'mono' (default) for Nerd Font Mono, 'normal' for Nerd Font.
    nerd_font_variant = 'mono',
  },

  completion = {
    -- <c-space> shows docs; auto_show pops them after a delay instead.
    documentation = { auto_show = false, auto_show_delay_ms = 500 },
  },

  sources = {
    default = { 'lsp', 'path', 'snippets' },
  },

  snippets = { preset = 'luasnip' },

  -- blink.cmp ships an optional Rust fuzzy matcher (downloads a prebuilt binary).
  -- 'lua' avoids that download; 'prefer_rust_with_warning' is faster. See `:help blink-cmp-config-fuzzy`
  fuzzy = { implementation = 'lua' },

  signature = { enabled = true },
}

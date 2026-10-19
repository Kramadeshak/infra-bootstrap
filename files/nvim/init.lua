--[[
  Neovim config — kickstart.nvim (master, `vim.pack` era) as the base, split into
  modules, plus my own additions.

  Layout
    init.lua            bootstrap: leader keys + module order (edit last)
    lua/config/         options, keymaps, autocmds, plugin-manager plumbing
    lua/plugins/        one file per concern (theme, ui, lsp, markdown, ai, ...)
    colors/             chromatic-engineer (my own colorscheme)

  Tracking upstream
    Upstream ships a single init.lua built from 10 numbered sections. Each section
    maps onto exactly one file here, so pulling upstream is a section-at-a-time diff:

      SECTION 1  OPTIONS            -> lua/config/options.lua
      SECTION 2  KEYMAPS/AUTOCMDS   -> lua/config/keymaps.lua + lua/config/autocmds.lua
      SECTION 3  PLUGIN MANAGER     -> lua/config/pack.lua
      SECTION 4  UI / CORE UX       -> lua/plugins/{theme,ui,gitsigns}.lua
      SECTION 5  SEARCH & NAV       -> lua/plugins/telescope.lua
      SECTION 6  LSP                -> lua/plugins/lsp.lua
      SECTION 7  FORMATTING         -> lua/plugins/formatting.lua
      SECTION 8  AUTOCOMPLETE       -> lua/plugins/completion.lua
      SECTION 9  TREESITTER         -> lua/plugins/treesitter.lua
      SECTION 10 OPTIONAL EXAMPLES  -> (dropped)

    Anything not in that table is mine:
      lua/plugins/{navigation,markdown,git,ai}.lua, colors/chromatic-engineer.lua
--]]

-- Leader keys. Must happen before any plugin loads (:h mapleader).
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Terminal has a Nerd Font selected? Drives icons across the whole config.
vim.g.have_nerd_font = true

-- Cache compiled Lua modules (:h lua-loader).
vim.loader.enable()

-- `vim.pack` landed in Neovim 0.12. Fail loudly rather than half-loading.
if vim.pack == nil then
  vim.notify('Neovim >= 0.12 required for vim.pack — plugins not loaded. Run :health.', vim.log.levels.ERROR)
  return
end

require 'config.pack' -- build hooks + gh() helper; must come before plugins.*
require 'config.options'
require 'config.keymaps'
require 'config.autocmds'

-- Order matters: theme first (so highlight groups exist), treesitter before
-- markdown (render-markdown needs a markdown parse tree).
require 'plugins.theme'
require 'plugins.ui'
require 'plugins.gitsigns'
require 'plugins.telescope'
require 'plugins.navigation'
require 'plugins.treesitter'
require 'plugins.markdown'
require 'plugins.lsp'
require 'plugins.completion'
require 'plugins.formatting'
require 'plugins.git'
require 'plugins.ai'

-- vim: ts=2 sts=2 sw=2 et

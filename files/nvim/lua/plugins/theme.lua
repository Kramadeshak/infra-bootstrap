-- Colorscheme. Upstream: kickstart "SECTION 4" (colorscheme block).
-- Change ACTIVE and nothing else. `:Theme <name>` switches at runtime.

local ACTIVE = 'chromatic-engineer' -- colors/chromatic-engineer.lua (mine)
local FALLBACK = 'catppuccin-mocha' -- installed below, always available

local pack = require 'config.pack'

-- Installed as a known-good fallback for the custom theme.
vim.pack.add { pack.gh 'catppuccin/nvim' }
---@diagnostic disable-next-line: missing-fields
require('catppuccin').setup {
  flavour = 'auto', -- latte, frappe, macchiato, mocha
  background = { light = 'latte', dark = 'mocha' },
  transparent_background = false,
  integrations = {
    gitsigns = true,
    nvimtree = true,
    which_key = true,
    blink_cmp = true,
    mini = { enabled = true },
  },
}

if not pcall(vim.cmd.colorscheme, ACTIVE) then
  vim.notify(('colorscheme %s failed to load — using %s'):format(ACTIVE, FALLBACK), vim.log.levels.WARN)
  vim.cmd.colorscheme(FALLBACK)
end

-- :Theme tokyonight-night | catppuccin-latte | chromatic-engineer ...
vim.api.nvim_create_user_command('Theme', function(opts)
  if pcall(vim.cmd.colorscheme, opts.args) then
    vim.notify('colorscheme: ' .. opts.args)
  else
    vim.notify('unknown colorscheme: ' .. opts.args, vim.log.levels.ERROR)
  end
end, {
  nargs = 1,
  desc = 'Switch colorscheme',
  complete = function(arg)
    local all = {}
    for _, dir in ipairs(vim.api.nvim_get_runtime_file('colors/*', true)) do
      table.insert(all, vim.fn.fnamemodify(dir, ':t:r'))
    end
    return vim.tbl_filter(function(name) return name:find(arg, 1, true) == 1 end, all)
  end,
})

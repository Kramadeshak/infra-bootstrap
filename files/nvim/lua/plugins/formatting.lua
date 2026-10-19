-- Formatting on demand / on save. Upstream: kickstart "SECTION 7: FORMATTING".

local pack = require 'config.pack'

vim.pack.add { pack.gh 'stevearc/conform.nvim' }

require('conform').setup {
  notify_on_error = false,
  format_on_save = function(bufnr)
    -- Opt-in list: only these filetypes format when you write the buffer.
    local enabled_filetypes = {
      lua = true,
      -- python = true,
      -- go = true,
      -- markdown = true, -- careful: prettier reflows prose and wikilinks
    }
    if enabled_filetypes[vim.bo[bufnr].filetype] then
      return { timeout_ms = 500 }
    else
      return nil
    end
  end,
  default_format_opts = {
    lsp_format = 'fallback', -- external formatter first, LSP formatting otherwise; false disables LSP
  },
  -- External formatters, e.g.:
  -- formatters_by_ft = { rust = { 'rustfmt' }, python = { 'isort', 'black' } },
  formatters_by_ft = {},
}

vim.keymap.set({ 'n', 'v' }, '<leader>f', function() require('conform').format { async = true } end, { desc = '[F]ormat buffer' })

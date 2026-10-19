-- Autocommands. Upstream: kickstart "SECTION 2: KEYMAPS & AUTOCMDS". See `:help lua-guide-autocommands`

-- Highlight yanked text. Try `yap` in normal mode. `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function() vim.hl.on_yank() end,
})

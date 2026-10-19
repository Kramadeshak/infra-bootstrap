-- Treesitter: highlighting, folds, indentation. Upstream: kickstart "SECTION 9: TREESITTER".
-- This is the `main` branch of nvim-treesitter (`:help nvim-treesitter-intro`) — note there is
-- no `nvim-treesitter.configs` / `ensure_installed` table any more; attaching is done by hand below.

local pack = require 'config.pack'

-- NOTE: a branch can be pinned with { src = ..., version = 'main' }, a tag range with
-- vim.version.range '1.*' (see lua/plugins/completion.lua).
vim.pack.add { { src = pack.gh 'nvim-treesitter/nvim-treesitter', version = 'main' } }

-- Parsers to install up front; anything else auto-installs when you open such a file.
local parsers = {
  'bash',
  'c',
  'diff',
  'html',
  'lua',
  'luadoc',
  'markdown',
  'markdown_inline',
  'query',
  'vim',
  'vimdoc',
  -- MY TWEAKS: languages I actually edit (markdown pair above is what render-markdown needs)
  'go',
  'python',
  'json',
  'yaml',
  'toml',
}
require('nvim-treesitter').install(parsers)

---@param buf integer
---@param language string
local function treesitter_try_attach(buf, language)
  -- The buffer may be gone by the time an install finishes.
  if not vim.api.nvim_buf_is_valid(buf) then return end

  -- Bail if there is no parser for this language.
  if not vim.treesitter.language.add(language) then return end

  -- Enable syntax highlighting and other treesitter features.
  vim.treesitter.start(buf, language)

  -- TS-based folds (uncomment to like them; see `:help folds`):
  -- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
  -- vim.wo.foldmethod = 'expr'

  -- TS-based indentation, falling back to Vim's indentexpr when a language has no indent query.
  local has_indent_query = vim.treesitter.query.get(language, 'indents') ~= nil
  if has_indent_query then vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()" end
end

local available_parsers = require('nvim-treesitter').get_available()
vim.api.nvim_create_autocmd('FileType', {
  callback = function(args)
    local buf, filetype = args.buf, args.match

    local language = vim.treesitter.language.get_lang(filetype)
    if not language then return end

    local installed_parsers = require('nvim-treesitter').get_installed 'parsers'

    if vim.tbl_contains(installed_parsers, language) then
      treesitter_try_attach(buf, language)
    elseif vim.tbl_contains(available_parsers, language) then
      -- Auto-install, then attach.
      require('nvim-treesitter').install(language):await(function() treesitter_try_attach(buf, language) end)
    else
      -- Parser may exist outside nvim-treesitter; try anyway.
      treesitter_try_attach(buf, language)
    end
  end,
})

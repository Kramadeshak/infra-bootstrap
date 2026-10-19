-- Chromatic Engineer — Neovim colorscheme
vim.opt.termguicolors = true
vim.opt.background = 'dark'

local p = {
  bg = '#17191D',
  surface = '#24272D',
  border = '#41464F',
  fg = '#E7E4DC',
  muted = '#5D636D',
  emerald = '#32B875',
  jade = '#4CA99A',
  amber = '#E8AA55',
  violet = '#A58AE8',
  blue = '#5C91BE',
  red = '#EB5C5C',
}

vim.cmd 'highlight clear'
if vim.g.syntax_on then
  vim.cmd 'syntax reset'
end
vim.g.colors_name = 'chromatic-engineer'

local highlights = {
  -- Inherit Ghostty's background and transparency
  Normal = { fg = p.fg, bg = 'NONE' },
  NormalNC = { fg = p.fg, bg = 'NONE' },
  NormalFloat = { fg = p.fg, bg = 'NONE' },
  FloatBorder = { fg = p.border, bg = 'NONE' },

  SignColumn = { fg = p.muted, bg = 'NONE' },
  EndOfBuffer = { fg = p.muted, bg = 'NONE' },
  FoldColumn = { fg = p.muted, bg = 'NONE' },
  Cursor = { fg = p.bg, bg = p.emerald },
  CursorLine = { bg = '#41464F' },
  LineNr = { fg = p.muted },
  CursorLineNr = { fg = p.emerald, bold = true },
  Visual = { bg = p.border },
  Search = { fg = p.bg, bg = p.amber },
  IncSearch = { fg = p.bg, bg = p.emerald, bold = true },
  MatchParen = { fg = p.amber, bold = true },

  Comment = { fg = p.muted, italic = true },
  Constant = { fg = p.amber },
  String = { fg = p.jade },
  Character = { fg = p.jade },
  Number = { fg = p.amber },
  Boolean = { fg = p.amber },
  Identifier = { fg = p.blue },
  Function = { fg = p.violet },
  Statement = { fg = p.emerald },
  Keyword = { fg = p.emerald, bold = true },
  Type = { fg = p.jade },
  Special = { fg = p.violet },
  PreProc = { fg = p.amber },
  Error = { fg = p.red, bold = true },
  Todo = { fg = p.bg, bg = p.amber, bold = true },

  DiagnosticError = { fg = p.red },
  DiagnosticWarn = { fg = p.amber },
  DiagnosticInfo = { fg = p.blue },
  DiagnosticHint = { fg = p.jade },

  Pmenu = { fg = p.fg, bg = p.surface },
  PmenuSel = { fg = p.bg, bg = p.emerald, bold = true },
  StatusLine = { fg = p.fg, bg = 'NONE' },
  StatusLineNC = { fg = p.muted, bg = 'NONE' },
  VertSplit = { fg = p.border },
  WinSeparator = { fg = p.border },
}

for group, style in pairs(highlights) do
  vim.api.nvim_set_hl(0, group, style)
end

-- Treesitter captures used by modern Neovim parsers
local treesitter = {
  ['@comment'] = { fg = p.muted, italic = true },
  ['@string'] = { fg = p.jade },
  ['@number'] = { fg = p.amber },
  ['@boolean'] = { fg = p.amber },
  ['@function'] = { fg = p.violet },
  ['@function.call'] = { fg = p.violet },
  ['@keyword'] = { fg = p.emerald, bold = true },
  ['@type'] = { fg = p.jade },
  ['@variable'] = { fg = p.fg },
  ['@constant'] = { fg = p.amber },
  ['@property'] = { fg = p.blue },
  ['@operator'] = { fg = p.fg },
}

for group, style in pairs(treesitter) do
  vim.api.nvim_set_hl(0, group, style)
end

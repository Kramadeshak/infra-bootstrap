-- Editor options. Upstream reference: kickstart "SECTION 1: OPTIONS".
-- Anything under "MY TWEAKS" is mine; everything above it tracks upstream 1:1,
-- which keeps future upstream diffs small.

-- Enable faster startup by caching compiled Lua modules.
vim.loader.enable()

-- Set <space> as the leader key.
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal.
vim.g.have_nerd_font = true

-- [[ Setting options ]]  See `:help vim.o`

-- Make line numbers default.
vim.o.number = true
-- Relative line numbers, handy for |count|j jumps:
-- vim.o.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example.
vim.o.mouse = 'a'

-- Don't show the mode, since it's already in the status line.
vim.o.showmode = false

-- Sync clipboard between OS and Neovim. Scheduled after UiEnter to avoid a
-- startup-time hit. Remove if you want an independent OS clipboard. `:help 'clipboard'`
vim.schedule(function() vim.o.clipboard = 'unnamedplus' end)

-- Enable break indent.
vim.o.breakindent = true

-- Enable undo/redo changes even after closing and reopening a file.
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term.
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default.
vim.o.signcolumn = 'yes'

-- Decrease update time.
vim.o.updatetime = 250

-- Decrease mapped sequence wait time.
vim.o.timeoutlen = 300

-- Configure how new splits should be opened.
vim.o.splitright = true
vim.o.splitbelow = true

-- Sets how Neovim displays certain whitespace characters. `:help 'list'`, `:help 'listchars'`
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type.
vim.o.inccommand = 'split'

-- Show which line your cursor is on.
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10

-- If an operation would fail due to unsaved changes (like `:q`), ask about saving.
-- See `:help 'confirm'`
vim.o.confirm = true

-- ============================================================
-- MY TWEAKS
-- ============================================================

-- GUI / GPU-terminal font (ignored by terminal emulators, honoured by Neovim GUIs).
vim.opt.guifont = 'JetBrains Mono:h14'

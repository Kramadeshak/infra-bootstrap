-- LSP: attach keymaps, server definitions, Mason-managed installs.
-- Upstream: kickstart "SECTION 6: LSP". `:Mason` shows what got installed.

local pack = require 'config.pack'

-- Status updates for LSP progress.
vim.pack.add { pack.gh 'j-hui/fidget.nvim' }
require('fidget').setup {}

-- Runs whenever an LSP attaches to a buffer.
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc, mode)
      mode = mode or 'n'
      vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end

    map('grn', vim.lsp.buf.rename, '[R]e[n]ame')
    map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })
    -- Not goto definition: e.g. in C this jumps to the header.
    map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

    -- Highlight references of the word under the cursor on CursorHold, cleared on CursorMoved.
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client:supports_method('textDocument/documentHighlight', event.buf) then
      local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })
      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })
      vim.api.nvim_create_autocmd('LspDetach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
        end,
      })
    end

    -- Inlay hints toggle, when the server supports them.
    if client and client:supports_method('textDocument/inlayHint', event.buf) then
      map('<leader>th', function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf }) end, '[T]oggle Inlay [H]ints')
    end
  end,
})

-- Enabled language servers. Keys are LSP server names; Mason installs them for us.
-- See `:help lsp-config` for the available keys of each entry.
---@type table<string, vim.lsp.Config>
local servers = {
  -- MY TWEAKS: the languages I write day to day.
  gopls = {}, -- Go
  pyright = {}, -- Python
  marksman = {}, -- Markdown (wikilinks, frontmatter, cross-file refs)

  -- clangd = {},
  -- tsc = {},        -- TypeScript via the builtin tsserver replacement; see :help lsp-config
  -- rust_analyzer = {} -- or the whole-plugin route: github.com/mrcjkb/rustaceanvim

  stylua = {}, -- Used to format Lua code (see lua/plugins/formatting.lua)

  -- Special Lua config, as recommended by the Neovim docs.
  lua_ls = {
    on_init = function(client)
      client.server_capabilities.documentFormattingProvider = false -- formatting is stylua's job

      if client.workspace_folders then
        local path = client.workspace_folders[1].name
        if path ~= vim.fn.stdpath 'config' and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc')) then return end
      end

      local current_settings = client.config.settings --[[@as lspconfig.settings.lua_ls]]
      client.config.settings.Lua = vim.tbl_deep_extend('force', current_settings.Lua, {
        runtime = {
          version = 'LuaJIT',
          path = { 'lua/?.lua', 'lua/?/init.lua' },
        },
        workspace = {
          checkThirdParty = false,
          -- NOTE: slow, and problematic when editing this very config; see
          -- https://github.com/neovim/nvim-lspconfig/issues/3189
          library = vim.api.nvim_get_runtime_file('', true),
        },
      })
    end,
    ---@type lspconfig.settings.lua_ls
    settings = {
      Lua = {
        format = { enable = false }, -- formatting is stylua's job
      },
    },
  },
}

vim.pack.add {
  pack.gh 'neovim/nvim-lspconfig',
  pack.gh 'mason-org/mason.nvim',
  pack.gh 'mason-org/mason-lspconfig.nvim',
  pack.gh 'WhoIsSethDaniel/mason-tool-installer.nvim',
}

-- Automatically install LSPs and related tools to stdpath.
require('mason').setup {}

-- Translates between nvim-lspconfig server names and mason.nvim package names
-- (e.g. lua_ls <-> lua-language-server).
require('mason-lspconfig').setup {
  automatic_enable = false, -- set true to also enable servers you installed by hand in :Mason
}

local ensure_installed = vim.tbl_keys(servers or {})
-- Add extra CLI tools here (they are not LSP servers): e.g. 'markdownlint-cli2'.
require('mason-tool-installer').setup { ensure_installed = ensure_installed }

for name, server in pairs(servers) do
  vim.lsp.config(name, server)
  vim.lsp.enable(name)
end

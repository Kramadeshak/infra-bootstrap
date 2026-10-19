-- AI helpers: minuet-ai ghost text against a local llama.cpp server, plus pi.nvim chat.
-- (mine, not upstream)
--
-- The endpoint is host-specific, so it is overridable without touching this file:
--   NVIM_LLM_ENDPOINT   default http://192.168.1.13:8080/v1/chat/completions
--   NVIM_LLM_MODEL      default qwen3-coder
--   NVIM_LLM_DISABLE=1  skip minuet entirely (e.g. on a laptop away from the home LAN)

local pack = require 'config.pack'

local endpoint = vim.env.NVIM_LLM_ENDPOINT or 'http://192.168.1.13:8080/v1/chat/completions'
local model = vim.env.NVIM_LLM_MODEL or 'qwen3-coder'

if vim.env.NVIM_LLM_DISABLE == nil then
  vim.pack.add { pack.gh 'milanglacier/minuet-ai.nvim' }

  require('minuet').setup {
    -- OpenAI-compatible chat completions, i.e. llama-server (`llama-server -m ... --port 8080`).
    provider = 'openai_compatible',
    provider_options = {
      openai_compatible = {
        model = model,
        end_point = endpoint,
        api_key = os.getenv 'NVIM_LLM_API_KEY' or 'TERM', -- llama-server ignores this by default
        stream = true, -- much better perceived latency
        optional = { max_tokens = 512, top_p = 0.9 },
      },
    },
    virtualtext = {
      auto_trigger_ft = { '*' }, -- trigger everywhere
      keymap = {
        accept = '<A-a>', -- accept the whole suggestion
        accept_line = '<A-l>', -- accept one line
        next = '<A-n>', -- next suggestion
        prev = '<A-p>', -- previous suggestion
        dismiss = '<A-e>', -- dismiss until next keystroke
      },
    },
  }
end

-- pi.nvim: minimal AI chat sidebar; it ships its own keymaps (`:Pi` to start).
vim.pack.add { pack.gh 'pablopunk/pi.nvim' }
require('pi').setup {}

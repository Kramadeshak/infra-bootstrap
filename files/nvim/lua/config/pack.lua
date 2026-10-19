-- Plugin plumbing for `vim.pack` — Neovim's built-in plugin manager.
-- Upstream reference: kickstart "SECTION 3: PLUGIN MANAGER INTRO".
-- See `:help vim.pack`, `:help vim.pack-examples`.
--
-- Day-to-day:
--   :lua vim.pack.update()                          update everything
--   :lua vim.pack.update(nil, { offline = true })   report pending updates only
--   :Packdel <name> / :Packadd <name>               enable, disable a plugin
--
-- Every plugin file in lua/plugins/ calls `vim.pack.add { gh 'owner/repo' }`
-- and then `require(...).setup {}`. No lockfile, no bootstrap download: the
-- plugins live under `stdpath('data')/site/pack/pack/*/`.

local M = {}

--- Most plugins live on GitHub; keeps the specs short.
---@param repo string 'owner/name'
---@return string
function M.gh(repo)
  return 'https://github.com/' .. repo
end

---@param name string
---@param cmd string[]
---@param cwd string
local function run_build(name, cmd, cwd)
  local result = vim.system(cmd, { cwd = cwd }):wait()
  if result.code ~= 0 then
    local output = (result.stderr ~= nil and result.stderr ~= '') and result.stderr or result.stdout or ''
    if output == '' then output = 'No output from build command.' end
    vim.notify(('Build failed for %s:\n%s'):format(name, output), vim.log.levels.ERROR)
  end
end

-- Some plugins need a build step after install/update (:h vim.pack-events).
vim.api.nvim_create_autocmd('PackChanged', {
  group = vim.api.nvim_create_augroup('user-pack-build', { clear = true }),
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if kind ~= 'install' and kind ~= 'update' then return end

    if name == 'telescope-fzf-native.nvim' and vim.fn.executable 'make' == 1 then
      run_build(name, { 'make' }, ev.data.path)
    elseif name == 'LuaSnip' and vim.fn.has 'win32' ~= 1 and vim.fn.executable 'make' == 1 then
      run_build(name, { 'make', 'install_jsregexp' }, ev.data.path)
    elseif name == 'nvim-treesitter' then
      if not ev.data.active then vim.cmd.packadd 'nvim-treesitter' end
      vim.cmd 'TSUpdate'
    end
  end,
})

return M

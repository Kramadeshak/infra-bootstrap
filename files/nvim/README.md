# nvim

My Neovim config: [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) `master` as the base,
split into modules, plus my own plugins. Deployed by `playbooks/common.yml` → `base_configs`
(see `roles/base_configs/tasks/nvim.yml`); the whole directory is copied to `~/.config/nvim`.

Requires **Neovim >= 0.12**: plugins are managed by the built-in [`vim.pack`](https://neovim.io/doc/user/lua.html#vim.pack),
not lazy.nvim. There is no lockfile — `:lua vim.pack.update()` updates everything.

## Where things live

| Want to change…                                 | File                                  |
| ----------------------------------------------- | ------------------------------------- |
| options (`scrolloff`, clipboard, leader…)       | `lua/config/options.lua`              |
| plain keymaps, diagnostics presentation         | `lua/config/keymaps.lua`              |
| autocommands                                    | `lua/config/autocmds.lua`             |
| plugin install/build plumbing                   | `lua/config/pack.lua`                 |
| colorscheme (incl. my `chromatic-engineer`)     | `lua/plugins/theme.lua`, `colors/`    |
| which-key groups, icons, statusline, mini       | `lua/plugins/ui.lua`                  |
| git signs / hunk keymaps                        | `lua/plugins/gitsigns.lua`            |
| Neogit / Diffview                               | `lua/plugins/git.lua`                 |
| Telescope pickers and keymaps                   | `lua/plugins/telescope.lua`           |
| nvim-tree, tmux navigation                      | `lua/plugins/navigation.lua`          |
| treesitter parsers / highlighting               | `lua/plugins/treesitter.lua`          |
| **markdown rendering (render-markdown tuning)** | `lua/plugins/markdown.lua`            |
| LSP servers                                     | `lua/plugins/lsp.lua`                 |
| completion, snippets                            | `lua/plugins/completion.lua`          |
| formatting                                      | `lua/plugins/formatting.lua`          |
| local LLM ghost text, AI chat                   | `lua/plugins/ai.lua`                  |

`init.lua` only sets leader keys and requires the modules in dependency order.

## Pulling from upstream

Upstream is one `init.lua` of 10 numbered sections; each maps to one file here (the table in
`init.lua`'s header comment has the mapping). Diff a section at a time:

```sh
curl -O https://raw.githubusercontent.com/nvim-lua/kickstart.nvim/master/init.lua
# then compare its "SECTION 6: LSP" against lua/plugins/lsp.lua, etc.
```

## Markdown rendering

`:checkhealth render-markdown` (parser + config validity) and `<leader>mc` (effective
non-default settings) both tell you whether your edits to `lua/plugins/markdown.lua` landed.
`:Theme <name>` switches colorscheme at runtime when you are chasing contrast problems.

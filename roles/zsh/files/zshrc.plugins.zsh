# Managed by Ansible — DO NOT EDIT

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
  git
  z
  sudo
  command-not-found
  fzf
  history-substring-search
  zsh-syntax-highlighting
  zsh-autosuggestions
)

# Powerlevel10k instant prompt
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

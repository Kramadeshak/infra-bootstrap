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
source $ZSH_CUSTOM/themes/powerlevel10k/powerlevel10k.zsh-theme
source $ZSH_CUSTOM/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZSH_CUSTOM/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

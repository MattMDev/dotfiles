# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH
export PATH=$HOME/go/bin":$HOME/.cargo/bin":$PATH

plugins=(
  git
)

# Source plugins
source "${HOME}/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh"

# Environment Variables
EDITOR='nvim'

# Aliases
alias gs='git status'
alias ga='git add'
alias gcm='git commit -m'
alias gp='git push'

# neovim
alias nwd='nvim .'

alias ls='eza -l'
alias ll='eza -l'
alias l='ls -la'
alias tree='eza -Ta'

# Zoxide (smart cd)
eval "$(zoxide init --cmd cd zsh)"

# Startship
eval "$(starship init zsh)"

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
 alias ohmyzsh="mate ~/.oh-my-zsh"




# Startup Script - TODO - switch with login manager
if [ "$(tty)" = "/dev/tty1" ]; then
    hyprland
fi

# opencode
export PATH=/home/matan/.opencode/bin:$PATH

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH
export PATH=$HOME/go/bin":$HOME/.cargo/bin":$PATH

# opencode
export PATH=/home/matan/.opencode/bin:$PATH

plugins=(
  git
)

# Source plugins
source "${HOME}/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh"

# History
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
setopt SHARE_HISTORY APPEND_HISTORY HIST_IGNORE_ALL_DUPS HIST_SAVE_NO_DUPS HIST_VERIFY

# Environment Variables
export EDITOR='nvim'

# Aliases
alias gs='git status'
alias ga='git add'
alias gcm='git commit -m'
alias gp='git push'
alias clean='git reset --hard; git pull --rebase'

# neovim
alias nwd='nvim .'

alias ls='eza -l'
alias ll='eza -l'
alias l='ls -la'
alias tree='eza -Ta'

# Zoxide (smart cd)
eval "$(zoxide init --cmd cd zsh)"

# FZF - fuzzy finder
source <(fzf --zsh)

# Startship
eval "$(starship init zsh)"


# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


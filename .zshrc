# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(
  git
  zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# Environment Variables
EDITOR='nvim'
ZSH_CUSTOM='/home/matan/.oh-my-zsh'

# Startup Script - TODO - switch with login manager
if [ "$(tty)" = "/dev/tty1" ]; then
    echo start-hyprland
fi


# Aliases
alias gs='git status'
alias ga='git add'
alias gcm='git commit -m'
alias gp='git push'

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
 alias ohmyzsh="mate ~/.oh-my-zsh"

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Path to custom stuff
ZSH_CUSTOM="$HOME/.zshcustom"

# Theme
ZSH_THEME="vine"

# Auto-update
zstyle ':omz:update' mode auto

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Bootstrap zsh auto suggestions
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
  git clone --quiet https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
fi

# Bootstrap zsh syntax highlight
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
  git clone --quiet https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
fi

# Plugins :D
plugins=(
  git
  git-extras
  yarn
  npm
  python
  pip
  docker
  colored-man-pages
  command-not-found
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='nvim'
fi

# Better "cd"
eval "$(zoxide init zsh)"
source <(fzf --zsh)

# Aliases
alias cd='z'
alias v='nvim'
alias vi='nvim'
alias vim='nvim'
alias lgit='lazygit'
alias msudo='sudo HOME=$HOME' # msudo as in My sudo (to keep config files when running stuff)

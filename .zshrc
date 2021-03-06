# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH="/usr/local/opt/ruby/bin:/usr/local/lib/ruby/gems/2.6.0/bin:$HOME/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$HOME/.nodenv/bin:$HOME/.nodenv/shims:$PATH:$HOME/Library/Python/2.7/bin:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
export EDITOR="micro"

#source ~/.bin/tmuxinator.zsh
#source ~/.tmux.conf

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="spaceship"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	git
	osx
	dotenv
	zsh-autosuggestions
	zsh-syntax-highlighting
#	zsh-apple-touchbar
)

source $ZSH/oh-my-zsh.sh

# User configuration

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Stop history from populating in other tabs
unsetopt inc_append_history
unsetopt share_history

# Open editor to edit this config file
alias zshconfig="micro ~/dotfiles/.zshrc"

# Open editor to edit local config file
alias zshconfig_local="micro ~/.custom.zshrc"

# Delete local git branches that were once tracking a remote branch that is now deleted
# source: https://stackoverflow.com/a/56609356
alias git_prune_local_dry="git remote prune origin && LANG=en git branch --format='%(if:equals=gone)%(upstream:track,nobracket)%(then)%(refname:short)%(end)' | grep '.'"
alias git_prune_local="git remote prune origin && LANG=en git branch --format='%(if:equals=gone)%(upstream:track,nobracket)%(then)%(refname:short)%(end)' | grep '.' | xargs git branch -D"

# Load nodenv automatically:
eval "$(nodenv init -)"

# Load bash profile
[[ -e ~/.profile ]] && emulate sh -c 'source ~/.profile'

# iterm2 shell integration
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# Whether to add newline to spaceship theme's prompt
export SPACESHIP_PROMPT_ADD_NEWLINE=false

# Hide spaceship theme's package version prompt
export SPACESHIP_PACKAGE_SHOW=false

# Hide spaceship theme's docker version prompt
export SPACESHIP_DOCKER_SHOW=false

# Change spaceship theme's prefix string
export SPACESHIP_PROMPT_PREFIXES_SHOW=false

# Load machine specific .zshrc (this should be made so it wont source itself and cause infinite loop)
[ -f ~/.custom.zshrc ] || echo 'do it' && source ~/.custom.zshrc

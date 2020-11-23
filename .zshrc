#------------------------
# zsh General Settings
#------------------------

# Env setting

export LANG=ja_JP.UTF-8
export GOPATH=$HOME/.go
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$HOME/.cargo/env

export PATH="$HOME/.rbenv/shims/bin:$PATH"
eval "$(rbenv init - zsh)"

# for MySQL v5.7
export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"
export DYLD_LIBRARY_PATH="/usr/local/opt/mysql@5.7/:$DYLD_LIBRARY_PATH"

# export PYENV_ROOT="$HOME/.pyenv"
# export PATH="$PYENV_ROOT/bin:$PATH"
# eval "$(pyenv init -)"

export PATH="/usr/local/opt/gnu-tar/libexec/gnubin:$PATH"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
# export PATH="$PATH:$HOME/.rvm/bin"
# [ -s /home/tksugar/.rvm/scripts/rvm ] && source /home/tksugar/.rvm/scripts/rvm

if [ -f .import_keys.rc ]; then
  source .import_keys.rc
fi

typeset -U path PATH

# Set up the prompt

autoload -Uz promptinit
promptinit
prompt adam1

setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# if [ $SHLVL = 1 ]; then
#   tmux
# fi

# zsh history
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

# Use modern completion system
# source /usr/local/bin/aws_zsh_completer.sh
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# Option
setopt print_eight_bit
setopt no_beep
setopt no_flow_control
setopt ignore_eof
setopt interactive_comments
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
setopt share_history
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt extended_glob

# Alias
alias vi='vim'
alias ls='exa'
alias ll='exa -l'
alias la='exa -a'
alias rf='rm -rf'
alias mk='touch'
alias mv='mv -i'
alias grep='grep --color'
alias df='df -h'
#alias ps='ps --sort=start_time'
alias vis="vim -S ~/.vim.session"
alias be="bundle exec"
alias tc='tmux save-buffer - | pbcopy'
alias nkflinux='nkf --overwrite -w -Lu'
# alias ctags='ctags --langmap=RUBY:.rb --exclude="*.js"  --exclude=".git*" -R .'
alias grepout="grep -v -e '^\s*#' -e '^\s*$'"
alias d="docker"
alias dc="docker-compose"
alias dm="docker-machine"
alias ec="ecs-cli"
alias dpr="docker rm -f \`docker ps -a -q\`"
alias dir="docker rmi -f \`docker images -a -q\`"
alias localmyq="mysql -u root -h 127.0.0.1 -p jmty_prototype_development"
alias resque_stop="ps -ef | grep resque | grep -v grep | awk '{print $2}' | xargs kill -9"
alias resque_start="cd ~/project/jmty/beagle && BACKGROUND=yes bundle exec rake resque:work QUEUE='*'"
alias get-gmo-data="python2.7 ~/Desktop/Selenium/gmo_payment.py"
alias xargs="gxargs"
alias tas="tmux attach-session -t"

# Global Alias
alias -g L='| less'
alias -g G='| grep'
alias -g C='| xsel --clipboard --input'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PATH="/usr/local/opt/imagemagick@6/bin:$PATH"
export AWS_REGION=ap-northeast-1
export PATH=/usr/local/opt/coreutils/libexec/gnubin:${PATH}
export MANPATH=/usr/local/opt/coreutils/libexec/gnuman:${MANPATH}

# peco for shell
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
setopt extended_history
setopt share_history
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_verify
setopt hist_reduce_blanks
setopt hist_save_no_dups
setopt hist_expire_dups_first
setopt hist_expand
setopt inc_append_history

function peco-select-history {
    BUFFER=`history -n -r 1 | peco --query "$LBUFFER"`
    CURSOR=$#BUFFER
    zle reset-prompt
}
zle -N peco-select-history
bindkey '^r' peco-select-history

# Git
#fpath=(~/.zsh $fpath)
if [ -f ${HOME}/.git-completion.zsh ]; then
  zstyle ':completion:*:*:git:*' script ~/.git-completion.zsh
fi

if [ -f ${HOME}/.git-prompt.sh ]; then
  source ${HOME}/.git-prompt.sh
fi

GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUPSTREAM=auto

setopt PROMPT_SUBST ; PS1='[%n@%m %c$(__git_ps1 " (%s)")]\$ '


#------------------------
# zsh General Settings
#------------------------

# Homebrew (最初に読み込んで以降のPATHが正しく通るようにする)
eval $(/opt/homebrew/bin/brew shellenv)

#------------------------
# Language environments
#------------------------

# Go
export GOPATH=$HOME/.go
export PATH=$PATH:$GOPATH/bin

# Rust
export PATH=$PATH:$HOME/.cargo/env

# Ruby (rbenv)
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# Python (pyenv)
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

# Node
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PATH="$HOME/.nodebrew/current/bin:$PATH"

#------------------------
# Other PATH / tool settings
#------------------------

export LANG=ja_JP.UTF-8
export AWS_REGION=ap-northeast-1

# GNU coreutils / tar を優先
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
export PATH="/usr/local/opt/gnu-tar/libexec/gnubin:$PATH"

# MySQL (5.7とHomebrewのmysql-clientが両方PATHに入っています。
# バージョンが意図せず切り替わる場合はどちらか一方に絞るのがおすすめです)
export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"
export DYLD_LIBRARY_PATH="/usr/local/opt/mysql@5.7/:$DYLD_LIBRARY_PATH"
export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"

# Added by Antigravity
export PATH="/Users/tk-sugar/.antigravity/antigravity/bin:$PATH"

typeset -U path PATH

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
# export PATH="$PATH:$HOME/.rvm/bin"
# [ -s /home/tksugar/.rvm/scripts/rvm ] && source /home/tksugar/.rvm/scripts/rvm

#------------------------
# Project-local secrets (要注意)
#------------------------
# cdした先のディレクトリに .import_keys.rc があると自動でsourceする仕組みでしたが、
# 未知のディレクトリに移動しただけで任意のコードが実行されてしまう可能性があるため、
# 一旦無効化しています。特定プロジェクトでだけ使う場合は、そのプロジェクトの
# .zshrc的な仕組み(direnvなど)に切り出すか、絶対パスを指定する方が安全です。
# if [ -f .import_keys.rc ]; then
#   source .import_keys.rc
# fi

#------------------------
# Shell options
#------------------------

setopt print_eight_bit
setopt no_beep
setopt no_flow_control
setopt ignore_eof
setopt interactive_comments
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
setopt extended_glob
setopt prompt_subst

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

#------------------------
# History
#------------------------

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

#------------------------
# Completion
#------------------------

autoload -Uz compinit && compinit  # Gitの補完を有効化

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

export CLICOLOR=1

#------------------------
# Aliases
#------------------------

alias vi='vim'
alias g='git'
alias ls='exa'   # 後継のezaに移行済みのツールです。exaが入っていないと動きません
alias ll='exa -la'
alias la='exa -a'
# alias cat='bat'
# alias ps='procs'
alias rf='rm -rf'
alias mk='touch'
alias mv='mv -i'
# alias grep='rg'
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
alias xargs="gxargs"
alias tas="tmux attach-session -t"
alias ave="aws-vault exec mfa-test --"

# python2.7前提のスクリプト。今のmacOSにはpython2.7が入っていない可能性が高く、
# 動かなければpyenv経由でpython2.7を入れるか、このエイリアス自体の削除を検討してください。
alias get-gmo-data="python2.7 ~/Desktop/Selenium/gmo_payment.py"

# Global Alias
alias -g L='| less'
alias -g G='| grep'
alias -g C='| xsel --clipboard --input'

#------------------------
# peco
#------------------------

function peco-select-history {
    BUFFER=`history -n -r 1 | peco --query "$LBUFFER"`
    CURSOR=$#BUFFER
    zle reset-prompt
}
zle -N peco-select-history
bindkey '^r' peco-select-history

function peco-src () {
  local selected_dir=$(ghq list -p | peco --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco-src
bindkey '^]' peco-src

function peco-branch () {
  local selected_dir=$(git branch | sed -e "s/^\*\s*//g" | peco --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    BUFFER="git checkout ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco-branch
bindkey '^b' peco-branch

#------------------------
# Prompt (Starship)
#------------------------
# 旧プロンプト(left-prompt/rprompt-git-current-branch)はStarshipに置き換えました。
# 設定は ~/.config/starship.toml (実体は dotfiles/starship.toml)
eval "$(starship init zsh)"

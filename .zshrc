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

# for Python
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

export PATH="/usr/local/opt/gnu-tar/libexec/gnubin:$PATH"
export PATH="$HOME/.nodebrew/current/bin:$PATH"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
# export PATH="$PATH:$HOME/.rvm/bin"
# [ -s /home/tksugar/.rvm/scripts/rvm ] && source /home/tksugar/.rvm/scripts/rvm

if [ -f .import_keys.rc ]; then
  source .import_keys.rc
fi

typeset -U path PATH

setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# zsh history
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

# Use modern completion system
# source /usr/local/bin/aws_zsh_completer.sh

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
alias g='git'
alias ls='exa'
alias ll='exa -la'
alias la='exa -a'
alias cat='bat'
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
alias localmyq="mysql -u root -h 127.0.0.1 -p jmty_prototype_development"
alias resque_stop="ps -ef | grep resque | grep -v grep | awk '{print $2}' | xargs kill -9"
alias resque_start="cd ~/project/jmty/beagle && BACKGROUND=yes bundle exec rake resque:work QUEUE='*'"
alias get-gmo-data="python2.7 ~/Desktop/Selenium/gmo_payment.py"
alias xargs="gxargs"
alias tas="tmux attach-session -t"
alias ave="aws-vault exec mfa-test --"

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

function peco-instances () {
  local instance=$(cat ~/jmty/instances.txt | peco --query "$LBUFFER")
  if [ -n "$instance" ]; then
    eid=$(echo $instance | awk -F'[,]' '{print $2}')
    BUFFER="aws-vault exec mfa-test -- aws ssm start-session --target $eid --region ap-northeast-1"
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco-instances
bindkey '^t' peco-instances

export CLICOLOR=1
autoload -Uz compinit && compinit  # Gitの補完を有効化

function left-prompt {
  name_t='179m%}'      # user name text clolr
  name_b='000m%}'    # user name background color
  path_t='255m%}'     # path text clolr
  path_b='031m%}'   # path background color
  arrow='087m%}'   # arrow color
  text_color='%{\e[38;5;'    # set text color
  back_color='%{\e[30;48;5;' # set background color
  reset='%{\e[0m%}'   # reset
  sharp='\uE0B0'      # triangle
  
  user="${back_color}${name_b}${text_color}${name_t}"
  dir="${back_color}${path_b}${text_color}${path_t}"
  echo "${user}%n%#@%m${back_color}${path_b}${text_color}${name_b}${sharp} ${dir}%~${reset}${text_color}${path_b}${sharp}${reset}\n${text_color}${arrow}→ ${reset}"
}

PROMPT=`left-prompt` 

# コマンドの実行ごとに改行
function precmd() {
    # Print a newline before the prompt, unless it's the
    # first prompt in the process.
    if [ -z "$NEW_LINE_BEFORE_PROMPT" ]; then
        NEW_LINE_BEFORE_PROMPT=1
    elif [ "$NEW_LINE_BEFORE_PROMPT" -eq 1 ]; then
        echo ""
    fi
}
# git ブランチ名を色付きで表示させるメソッド
function rprompt-git-current-branch {
  local branch_name st branch_status

  branch='\ue0a0'
  color='%{\e[38;5;' #  文字色を設定
  green='114m%}'
  red='001m%}'
  yellow='227m%}'
  blue='033m%}'
  reset='%{\e[0m%}'   # reset

  if [ ! -e  ".git" ]; then
    # git 管理されていないディレクトリは何も返さない
    return
  fi
  branch_name=`git rev-parse --abbrev-ref HEAD 2> /dev/null`
  st=`git status 2> /dev/null`
  if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
    # 全て commit されてクリーンな状態
    branch_status="${color}${green}${branch}"
  elif [[ -n `echo "$st" | grep "^Untracked files"` ]]; then
    # git 管理されていないファイルがある状態
    branch_status="${color}${red}${branch}?"
  elif [[ -n `echo "$st" | grep "^Changes not staged for commit"` ]]; then
    # git add されていないファイルがある状態
    branch_status="${color}${red}${branch}+"
  elif [[ -n `echo "$st" | grep "^Changes to be committed"` ]]; then
    # git commit されていないファイルがある状態
    branch_status="${color}${yellow}${branch}!"
  elif [[ -n `echo "$st" | grep "^rebase in progress"` ]]; then
    # コンフリクトが起こった状態
    echo "${color}${red}${branch}!(no branch)${reset}"
    return
  else
    # 上記以外の状態の場合
    branch_status="${color}${blue}${branch}"
  fi
  # ブランチ名を色付きで表示する
  echo "${branch_status}$branch_name${reset}"
}
# プロンプトが表示されるたびにプロンプト文字列を評価、置換する
setopt prompt_subst
# プロンプトの右側にメソッドの結果を表示させる
RPROMPT='`rprompt-git-current-branch`'


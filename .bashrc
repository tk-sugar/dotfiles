# .bashrc

# User specific environment and startup programs

GOPATH=$HOME/go

export GOPATH

PATH=$PATH:$HOME/bin
PATH=$PATH:$HOME/.rbenv/bin
PATH=$PATH:$HOME/go/bin:/usr/local/go/bin

export PATH

eval "$(rbenv init -)"

PS1="[\t \u@\h:\w ] $ "

export PS1

# Source bash_completion definitions
if [ -f /etc/bash_completion ]; then
  source /etc/bash_completion
fi

# Source aliases definitions
source ~/.bash_aliases

# Source git definitions
source ~/.git-completion.bash
source ~/.git-prompt.sh

# Setting
HISTSIZE=1000
HISTFILESIZE=2000

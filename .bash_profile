# .bash_profile

# Source bashrc definitions
source ~/.bashrc

# User specific environment and startup programs

PATH=$PATH:$HOME/bin
PATH=$PATH:$HOME/.rbenv/bin

export PATH

GOPATH=$HOME/go

export GOPATH

eval "$(rbenv init -)"

PS1="[\t \u@\h:\w ] $ "

export PS1

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

export PATH="$HOME/.cargo/bin:$PATH"

# .bash_profile

# Source bashrc definitions
source ~/.bashrc

# User specific environment and startup programs

PATH=$PATH:$HOME/bin
PATH=$PATH:$HOME/.rbenv/bin

export PATH

eval "$(rbenv init -)"

PS1="[\t \u@\h:\w ] $ "

export PS1

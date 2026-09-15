# The following lines were added by Docker Desktop to add commands to your PATH.
export PATH="$PATH:/Users/tk-sugar/.docker/bin"
# End of Docker Desktop section.

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

#power-shell
function _update_ps1() {
    export PS1=""
}
export PROMPT_COMMAND="_update_ps1; "
#power-shell


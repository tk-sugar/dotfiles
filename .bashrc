# .bashrc

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

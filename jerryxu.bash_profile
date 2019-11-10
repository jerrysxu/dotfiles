source ~/tools/dotfiles/jerryxu.common.sh

# Input -----------------------------------------------------------------------
# use Shift-TAB to complete
bind '"\e[Z":menu-complete'

#bind '"\C-j":menu-complete'
#bind '"\C-k":menu-complete-backward'

bind "set completion-ignore-case on" # note: bind used instead of sticking these in .inputrc
bind "set show-all-if-ambiguous On" # show list automatically, without double tab
bind "set bell-style none" # no bell

# iterm2 integration
source ~/tools/dotfiles/iterm2_shell_integration.bash

# Node Version Manager
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion" ] && . "/usr/local/opt/nvm/etc/bash_completion"  # This loads nvm bash_completion

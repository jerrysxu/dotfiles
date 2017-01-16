# Alias -----------------------------------------------------------------------
alias lr='ls -ltra'
alias ve="source ./venv/bin/activate"

# Input -----------------------------------------------------------------------
# use Shift-TAB to complete
bind '"\e[Z":menu-complete'

#bind '"\C-j":menu-complete'
#bind '"\C-k":menu-complete-backward'
if [ -f /etc/bash_completion ]; then
 . /etc/bash_completion
fi

bind "set completion-ignore-case on" # note: bind used instead of sticking these in .inputrc
bind "set show-all-if-ambiguous On" # show list automatically, without double tab
bind "set bell-style none" # no bell

# Colors ----------------------------------------------------------------------
export TERM=screen
export GREP_OPTIONS='--color=auto' GREP_COLOR='1;32'
export CLICOLOR=1

alias ls='ls --color=auto'
# ls colors, see: http://www.linux-sxs.org/housekeeping/lscolors.html
export LS_COLORS='di=1:fi=0:ln=31:pi=5:so=5:bd=5:cd=5:or=31:mi=0:ex=35:*.rb=90'

# Setup some colors to use later in interactive shell or scripts
export COLOR_NC='\033[0m' # No Color
export COLOR_WHITE='\033[1;37m'
export COLOR_BLACK='\033[0;30m'
export COLOR_BLUE='\033[0;34m'
export COLOR_LIGHT_BLUE='\033[1;34m'
export COLOR_GREEN='\033[0;32m'
export COLOR_LIGHT_GREEN='\033[1;32m'
export COLOR_CYAN='\033[0;36m'
export COLOR_LIGHT_CYAN='\033[1;36m'
export COLOR_RED='\033[0;31m'
export COLOR_LIGHT_RED='\033[1;31m'
export COLOR_PURPLE='\033[0;35m'
export COLOR_LIGHT_PURPLE='\033[1;35m'
export COLOR_BROWN='\033[0;33m'
export COLOR_YELLOW='\033[1;33m'
export COLOR_GRAY='\033[1;30m'
export COLOR_LIGHT_GRAY='\033[0;37m'
alias colorslist="set | egrep 'COLOR_\w*'"  # lists all the colors

# History ---------------------------------------------------------------------
export HISTCONTROL=ignoredups
#export HISTCONTROL=erasedups
export HISTFILESIZE=3000
export HISTIGNORE="ls:cd:[bf]g:exit:..:...:ll:lla"
alias h=history

# Prompts ---------------------------------------------------------------------
virtualenv_prompt() {
  if [ ! -z "$VIRTUAL_ENV" ]
  then
    local env=$(dirname $VIRTUAL_ENV)
    echo " [${env##*/}]"
  fi
}

prompt_func() {
  previous_return_value=$?;
  prompt=" \[${COLOR_PURPLE}\]\w\[${COLOR_BLUE}\]$(virtualenv_prompt)\[${COLOR_PURPLE}\]$(conda_prompt)\[${COLOR_NC}\] "

  if test $previous_return_value -eq 0
  then
      PS1="${prompt}> "
  else
      PS1="${prompt}\[${COLOR_RED}\]> \[${COLOR_NC}\]"
  fi
}
PROMPT_COMMAND=prompt_func

export PS2='> '    # Secondary prompt
export PS3='#? '   # Prompt 3
export PS4='+'     # Prompt 4

# Navigation ------------------------------------------------------------------
alias ..='cd ..'
alias ...='cd .. ; cd ..'
cl() { cd $1; ls -la; }

# Other aliases ---------------------------------------------------------------
alias ll='ls -hl'
alias la='ls -a'
alias lla='ls -lah'

# Search ----------------------------------------------------------------------
# Use ack for grepping and find if ack is available
# sudo port install p5-app-ack
if type -P ack &>/dev/null ; then
  g(){
    ack "$*" --color-match=green --color-filename=blue --smart-case
  }
  grb(){
    ack "$*" --type=ruby --color-match=green --color-filename=blue --smart-case
  }
  gw(){
    ack "$*" --color-match=green --color-filename=blue --word-regexp --smart-case
  }
  gnolog(){
    ack "$*" --ignore-dir=log --color-match=green --color-filename=blue --smart-case
  }
  f(){
    ack -i -g ".*$*[^\/]*$" | highlight blue ".*/" green "$*[^/]"
  }
else
  g(){
    grep -Rin $1 *
  }
  f(){
    find . -iname "$1"
  }
fi

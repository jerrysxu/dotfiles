# Path ------------------------------------------------------------------------
export PATH=~/tools/dotfiles/bin:$PATH

if [ -d /usr/local/bin ]; then
  export PATH=/usr/local/bin:$PATH
fi

if [ -d /opt/homebrew/bin ]; then
  export PATH=/opt/homebrew/bin:$PATH
fi

if [ -d "/Users/jerryxu/Library/Application Support/JetBrains/Toolbox/scripts" ]; then
  export PATH="/Users/jerryxu/Library/Application Support/JetBrains/Toolbox/scripts":$PATH
fi

# Alias -----------------------------------------------------------------------
alias st="open -a SourceTree"
alias ls="lsd"
alias ll="lsd -ltra"
alias cat="bat"
alias ve="source ./venv/bin/activate"
alias mac="/tools/dotfiles/bin/m1ddc display 2 set input 17"
alias pc="/tools/dotfiles/bin/m1ddc display 2 set input 15"
alias fbat="fzf --preview \"bat --color=always --style=numbers --line-range=:500 {}\""

###############################################################################
# java version Java SE 8, 11, 17 and 21 are LTS releases
# export JAVA_HOME=`/usr/libexec/java_home -v 11`

# added by Anaconda 2.1.0 installer
function ana {
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/opt/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/opt/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
}

function xtitle () {
  echo -ne "\033]0;"$@"\007"
}

# Use lf to switch directories and bind it to ctrl-o
function lfcd() {
  tmp="$(mktemp)"
  lf -last-dir-path="$tmp" "$@"
  if [ -f "$tmp" ]; then
    dir="$(cat "$tmp")"
    rm -f "$tmp"
    [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
  fi
}
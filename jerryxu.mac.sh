# Path ------------------------------------------------------------------------
export PATH=~/tools/dotfiles/bin:$PATH

if [ -d /usr/local/bin ]; then
  export PATH=/usr/local/bin:$PATH
fi

if [ -d /opt/homebrew/bin ]; then
  export PATH=/opt/homebrew/bin:$PATH
fi

if [ -d /opt/facebook/bin ]; then
  export PATH=/opt/facebook/bin:$PATH
fi

# Alias -----------------------------------------------------------------------
alias st="open -a SourceTree"
alias lr="ls -ltra"
alias ve="source ./venv/bin/activate"

###############################################################################
# java version
export JAVA_HOME=`/usr/libexec/java_home -v 11`

# added by Anaconda 2.1.0 installer
function ana {
  # >>> conda initialize >>>
  # !! Contents within this block are managed by 'conda init' !!
  __conda_setup="$('/Users/jerryxu/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
  if [ $? -eq 0 ]; then
      eval "$__conda_setup"
  else
      if [ -f "/Users/jerryxu/opt/anaconda3/etc/profile.d/conda.sh" ]; then
          . "/Users/jerryxu/opt/anaconda3/etc/profile.d/conda.sh"
      else
          export PATH="/Users/jerryxu/opt/anaconda3/bin:$PATH"
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

neofetch --ascii ~/tools/dotfiles/vendetta.ascii.60.txt

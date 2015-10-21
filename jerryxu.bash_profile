# OS --------------------------------------------------------------------------
# See following for more information: http://www.infinitered.com/blog/?p=10
# Identify OS and Machine -----------------------------------------
export OS=`uname -s | sed -e 's/  */-/g;y/ABCDEFGHIJKLMNOPQRSTUVWXYZ/abcdefghijklmnopqrstuvwxyz/'`
export OSVERSION=`uname -r`; OSVERSION=`expr "$OSVERSION" : '[^0-9]*\([0-9]*\.[0-9]*\)'`
export MACHINE=`uname -m | sed -e 's/  */-/g;y/ABCDEFGHIJKLMNOPQRSTUVWXYZ/abcdefghijklmnopqrstuvwxyz/'`
export PLATFORM="$MACHINE-$OS-$OSVERSION"
# Note, default OS is assumed to be OSX

# Path ------------------------------------------------------------------------
if [ "$OS" = "darwin" ] ; then
  # OS-X Specific, with MacPorts and MySQL installed
  if [ -d /opt/local ]; then
    export PATH=/opt/local/bin:/opt/local/sbin:$PATH
  fi
  export PATH=~/tools/dotfiles/bin:~/tools/dotfiles/bin/darwin:$PATH
else
  export PATH=~/tools/dotfiles/bin:~/tools/dotfiles/bin/linux:$PATH
fi

if [ -d /usr/local/bin ]; then
	export PATH=/usr/local/bin:$PATH 
fi

# Remote ----------------------------------------------------------------------
if [[ -z $SSH_CONNECTION ]]; then
  export IS_REMOTE=false
else
  export IS_REMOTE=true
fi

# fix SSH sock file name for tmux
if [ "$OS" = "linux" ] ; then
  if [ $IS_REMOTE = 'true' ] ; then
    if [ "x$SSH_AUTH_SOCK" != "x/tmp/$USER-ssh-auth-sock" ]; then
      ln -snf $SSH_AUTH_SOCK /tmp/$USER-ssh-auth-sock
      SSH_AUTH_SOCK=/tmp/$USER-ssh-auth-sock
      export SSH_AUTH_SOCK
    fi
  fi
fi

# Alias -----------------------------------------------------------------------
if [ "$OS" = "darwin" ] ; then
  # AppleScripts
  alias fixshr="osascript ~/tools/dotfiles/applescripts/RemoteLogin.scpt"
  alias fixkb="osascript ~/tools/dotfiles/applescripts/KeyboardDisableMissionControl.scpt"
  alias opfs="osascript ~/tools/dotfiles/applescripts/MonitorFoscamUploads.scpt"

  alias st="open -a SourceTree"
  alias kd="/Applications/kdiff3.app/Contents/MacOS/kdiff3"
  alias fixcam="sudo killall VDCAssistant"
  alias fixmc="osascript -e 'quit application \"Dock\"'"

  function maccls { 
    osascript -e 'tell application "System Events" to keystroke "k" using command down' 
  }
fi

alias lr="ls -ltra"

# Input -----------------------------------------------------------------------
# use Shift-TAB to complete
bind '"\e[Z":menu-complete'

#bind '"\C-j":menu-complete'
#bind '"\C-k":menu-complete-backward'

bind "set completion-ignore-case on" # note: bind used instead of sticking these in .inputrc
bind "set show-all-if-ambiguous On" # show list automatically, without double tab
bind "set bell-style none" # no bell

###############################################################################
if [ "$OS" = "darwin" ] ; then
  # java version
  export JAVA_HOME=`/usr/libexec/java_home -v 1.7`

  if [ -d ~/bin ]; then
    export PATH=~/bin:$PATH  # add your bin folder to the path, if you have it.  It's a good place to add all your scripts
  fi

  # DevBox
  function svb {
    for s in local api lyftqueue pricing ats eta tripestimator fare; do ./service $1 $s; done
  }
  alias sve="./service enter"
  alias svo="./service open"
  alias svr="./service restart"
  alias svs="./service start"
  alias svu="./service status | highlight green '.*running.*'"
  alias ve="source ./venv/bin/activate"

  # Android Studio
  export ANDROID_HOME=/Users/jerryxu/Library/Android/sdk
  export PATH=$ANDROID_HOME/platform-tools:$ANDROID_HOME/tools:$PATH

  # RVM
  export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

  # Production Redshift ("Lyfthouse")
  alias ppl='ssh gateway.ln'
  alias lh='psql -q -h localhost -p 3439 -U lyftdata lyfthouseprod'
  alias lhm='psql -h localhost -p 3439 -U lyftmaster lyfthouseprod'

  # lyftdata
  export LYFTDATA_HOME=~/src/lyft/lyftdata
  export PYTHONPATH=$LYFTDATA_HOME/lib
  export PATH=$PATH:$LYFTDATA_HOME/bin

  # maven
  export PATH=/Users/jerryxu/src/apache-maven/bin:$PATH

  # appcatalyst
  export PATH=/opt/vmware/appcatalyst/bin:$PATH

  # For better psql paging
  export PAGER=less
  # export LESS="-iMSx4 -FX"

  ### Added by the Heroku Toolbelt
  export PATH="/usr/local/heroku/bin:$PATH"

  # added by Anaconda 2.1.0 installer
  function ana {
    export PATH="/Users/jerryxu/anaconda/bin:$PATH"
  }

  export DOCKER_IP=`cat ~/.docker-ip`
  alias dockr='docker -H tcp://$DOCKER_IP:4243'

  alias dockrmongo='dockr run -d -v /data/vmwaredocker/mongodb:/data -p 27017:27017 -p 28017:28017 dockerfile/mongodb'
  # alias dockrmysql='dockr run --name dockermysql -d mysql -e MYSQL_ROOT_PASSWORD=sa -v /data/vmwaredocker/mysql:/var/lib/mysql -p 0.0.0.0:3306:3306'
  alias dockrmysql='dockr run -d -e MYSQL_ROOT_PASSWORD=sa -p 0.0.0.0:3306:3306 mysql'

  # spark
  export SPARK_HOME=/Users/jerryxu/src/opensource/spark
  export PYTHONPATH=$PYTHONPATH:$SPARK_HOME/python:$SPARK_HOME/python/lib/py4j-0.8.2.1-src.zip

  # VMWare appcatalyst
  alias startvm="nohup /opt/vmware/appcatalyst/bin/appcatalyst-daemon >/dev/null 2>&1 &"
fi

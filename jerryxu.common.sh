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
  export PATH=/usr/local/opt/python/libexec/bin:/usr/local/bin:$PATH
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
  alias opmfu="osascript ~/tools/dotfiles/applescripts/MFUFinderFolders.scpt"
  alias lcs="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"
  alias bcam="osascript ~/tools/dotfiles/applescripts/AddCamToSidebar.scpt"

  alias st="open -a SourceTree"
  alias kd="/Applications/kdiff3.app/Contents/MacOS/kdiff3"
  alias fixcam="sudo killall VDCAssistant"
  alias fixmc="osascript -e 'quit application \"Dock\"'"

  function maccls {
    osascript -e 'tell application "System Events" to keystroke "k" using command down'
  }
fi

alias lr="ls -ltra"
alias ve="source ./venv/bin/activate"

###############################################################################
if [ "$OS" = "darwin" ] ; then
  # java version
  export JAVA_HOME=`/usr/libexec/java_home -v 1.8`

  if [ -d ~/bin ]; then
    export PATH=~/bin:$PATH  # add your bin folder to the path, if you have it.  It's a good place to add all your scripts
  fi

  # Android Studio
  export ANDROID_HOME=~/Library/Android/sdk
  export PATH=$ANDROID_HOME/platform-tools:$ANDROID_HOME/tools:$PATH

  # RVM
  export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

  # maven
  export PATH=~/src/apache-maven/bin:$PATH

  # gradle
  export PATH=~/src/gradle/bin:$PATH

  # appcatalyst
  # export PATH=/opt/vmware/appcatalyst/bin:$PATH

  # For better psql paging
  export PAGER=less
  # export LESS="-iMSx4 -FX"

  ### Added by the Heroku Toolbelt
  # export PATH="/usr/local/heroku/bin:$PATH"

  # added by Anaconda 2.1.0 installer
  function ana {
    # >>> conda initialize >>>
    # !! Contents within this block are managed by 'conda init' !!
    __conda_setup="$('/Users/jerryxu/opt/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
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

  # export DOCKER_IP=`cat ~/.docker-ip`
  # alias dockr='docker -H tcp://$DOCKER_IP:4243'

  # alias dockrmongo='dockr run -d -v /data/docker/mongodb:/data -p 27017:27017 -p 28017:28017 dockerfile/mongodb'
  # alias dockrmysql='dockr run --name dockermysql -d mysql -e MYSQL_ROOT_PASSWORD=sa -v /data/docker/mysql:/var/lib/mysql -p 0.0.0.0:3306:3306'
  # alias dockrmysql='dockr run -d -e MYSQL_ROOT_PASSWORD=sa -p 0.0.0.0:3306:3306 mysql'

  # spark
  # export SPARK_HOME=/Users/jerryxu/src/sandbox/spark
  # export PYTHONPATH=$PYTHONPATH:$SPARK_HOME/python:$SPARK_HOME/python/lib/py4j-0.8.2.1-src.zip

  # VMWare appcatalyst
  # alias startvm="nohup /opt/vmware/appcatalyst/bin/appcatalyst-daemon >/dev/null 2>&1 &"

  ec2inst() {
    aws ec2 describe-instances --filters "Name=tag:Name, Values=*$1*" --query "Reservations[*].Instances[*][Tags[?Key=='Name'].Value[],PublicDnsName]" --output text
  }

  sshhome() {
    cd ~/src/sandbox/tools
    source venv/bin/activate
    sshuttle --dns -r pi@jerryxu.noip.me 0/0
  }

  sshoffice() {
    cd ~/src/sandbox/tools
    source venv/bin/activate
    sshuttle --dns -r datatron@officebay.hopto.org 0/0
  }

  function xtitle () {
    echo -ne "\033]0;"$@"\007"
  }

  function infoqd () {
    infoqscraper presentation download -t h264_overlay $1
  }

  function pcam () {
    find  "/Volumes/Lexar/Box Sync/foscam/r1/R2C_00626E936C72/snap/" -iname "*.jpg" -exec rm {} \;
    # rm -rf "/Volumes/Lexar/Box Sync/foscam/1/FI9821W_00626E4D02BF/snap"/*
    rm -rf "/Volumes/Lexar/Box Sync/foscam/r1/R2C_00626E936C72/record"/*
    find  "/Volumes/Lexar/Box Sync/foscam/r2/R2C_00626E937BC8/snap/" -iname "*.jpg" -exec rm {} \;
    # rm -rf "/Volumes/Lexar/Box Sync/foscam/2/FI9821W_C4D6553B24E0/snap"/*
    rm -rf "/Volumes/Lexar/Box Sync/foscam/r2/R2C_00626E937BC8/record"/*
    find  "/Volumes/Lexar/Box Sync/foscam/r3/R2C_00626E937B0E/snap/" -iname "*.jpg" -exec rm {} \;
    rm -rf "/Volumes/Lexar/Box Sync/foscam/r3/R2C_00626E937B0E/record"/*
    find  "/Volumes/Lexar/Box Sync/foscam/r4/R2C_00626E936C01/snap/" -iname "*.jpg" -exec rm {} \;
    rm -rf "/Volumes/Lexar/Box Sync/foscam/r4/R2C_00626E936C01/record"/*
    rm -rf "/Volumes/Lexar/Box Sync/foscam/r5/R2C_00626E936DF4/snap"/*
    rm -rf "/Volumes/Lexar/Box Sync/foscam/r5/R2C_00626E936DF4//record"/*
  }

  function vcam () {
    /Applications/Sequential.app/Contents/MacOS/Sequential "/Volumes/Lexar/Box Sync/foscam/r1/R2C_00626E936C72/snap" "/Volumes/Lexar/Box Sync/foscam/r2/R2C_00626E937BC8/snap" "/Volumes/Lexar/Box Sync/foscam/r5/R2C_00626E936DF4/snap" &
  }

  function vcamd () {
    /Applications/Sequential.app/Contents/MacOS/Sequential "/Volumes/Lexar/Box Sync/foscam/r3/R2C_00626E937B0E/snap" "/Volumes/Lexar/Box Sync/foscam/r4/R2C_00626E936C01/snap" &
  }

  function denter() {
   if [ -z "$1" ]; then echo "\nPlease:\n denter [ContainerName]\n\nView:\n docker container ls\n" ;else docker exec -it "$1" /bin/bash ;fi;
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

  unalias g &>/dev/null
  # Use ack for grepping and find if ack is available
  if which ack &>/dev/null ; then
    function gg() {
      ack "$*" --smart-case
    }
    function gwd() {
      ack "$*" --word-regexp --smart-case
    }
    function gf() {
      ack -i --type-set='all:match:.*' -k -g ".*${*}[^\/]*$"
    }
  fi
  function g() {
    grep -Rin $1 *
  }
  function f() {
    find . -iname "*$1*"
  }

  neofetch --ascii ~/tools/dotfiles/vendetta.ascii.60.txt
fi

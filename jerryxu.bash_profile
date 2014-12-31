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
# AppleScripts
alias fixshr="osascript ~/tools/dotfiles/applescripts/RemoteLogin.scpt"
alias fixkb="osascript ~/tools/dotfiles/applescripts/KeyboardDisableMissionControl.scpt"

alias st="open -a SourceTree"
alias kd="/Applications/kdiff3.app/Contents/MacOS/kdiff3"
alias fixcam="sudo killall VDCAssistant"
alias fixmc="osascript -e 'quit application \"Dock\"'"

alias lr="ls -ltra"

function maccls { 
  osascript -e 'tell application "System Events" to keystroke "k" using command down' 
}

# Input -----------------------------------------------------------------------
# use TAB to complete
#bind 'TAB:menu-complete'

bind "set completion-ignore-case on" # note: bind used instead of sticking these in .inputrc
bind "set show-all-if-ambiguous On" # show list automatically, without double tab
bind "set bell-style none" # no bell

###############################################################################
export PATH=~/src/play-2.2.2:~/src/apache-maven-3.2.1/bin:$PATH

# jave version
if [ "$OS" = "darwin" ] ; then
  export JAVA_HOME=`/usr/libexec/java_home -v 1.6`
fi

# set Hadoop environment
# Hadoop 2
#export HADOOP_PREFIX="/Users/jxu/src/opensource/hadoop/hadoop-2.5.0"
#export HADOOP_HOME=$HADOOP_PREFIX
#export HADOOP_COMMON_HOME=$HADOOP_PREFIX
#export HADOOP_CONF_DIR=$HADOOP_PREFIX/etc/hadoop
#export HADOOP_HDFS_HOME=$HADOOP_PREFIX
#export HADOOP_MAPRED_HOME=$HADOOP_PREFIX
#export HADOOP_YARN_HOME=$HADOOP_PREFIX
# Hadoop 1
#export HADOOP_PREFIX="/Users/jxu/src/opensource/hadoop/hadoop-1.2.1"
export HADOOP_PREFIX="/Users/jxu/src/opensource/hadoop/hadoop-2.0.0-cdh4.7.1"
export HADOOP_CONF_DIR=$HADOOP_PREFIX/etc/hadoop-mapreduce1
export PATH=$PATH:$HADOOP_PREFIX/bin-mapreduce1

export PATH=/box/www/devtools-checkout/bin:$PATH

if [ -d ~/bin ]; then
  export PATH=~/bin:$PATH  # add your bin folder to the path, if you have it.  It's a good place to add all your scripts
fi


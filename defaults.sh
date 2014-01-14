#
# Kims bash extensions
# defaults.sh: contains reasonable defaults.
#

# default prompt colors
export ROOTCOLOR=$LTRED
export ROOTDIRCOLOR=$RED
export HOSTCOLOR=$GREEN
export NAMECOLOR=$LTBLUE
export DIRCOLOR=$CYAN

# globals
export PATH=$PATH:~/bin:$KBASH/bin

# vim
export VISUAL="vim"
export EDITOR=$VISUAL
export VIMINIT="set rtp+=$KBASH/vim | source $KBASH/rc/.vimrc"

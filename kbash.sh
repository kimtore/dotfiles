#
# Kims bash extensions
# kbash.sh: bootstraps bash and transforms it into kbash
#

# Do not allow running this script standalone
if [ "$BASH_ARGV" == "" ]; then
	echo "fatal: please use \`source /path/to/kbash.sh'"
	exit 1
fi

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups

# check the window size after each command and, if necessary, update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# KBASH: where are the source file tree?
scriptpath=$BASH_ARGV
export KBASH=`dirname $scriptpath`

# «old and crusty»
unset TERMCAP

# Standard aliases
alias ls='ls --color'
alias dir='ls --color --format=long'
alias dirs='ls --color --format=long -d */'
alias dirf='ls --color --format=long --classify | egrep -v "/$"'
alias scpresume='rsync --partial --progress --rsh=ssh'
alias gitall='git commit -a -m'
alias ipcalc='ipcalc --nocolor'
alias tax='tmux detach && tmux attach || tmux'
alias g='ack-grep'

# Colorized grepping
alias grep='grep --color'
alias egrep='egrep --color'
alias less='less -R'

# Vimrc on all systems
alias vim="vim -u $KBASH/rc/.vimrc"

# Include a colors file
[ -f "$KBASH/colors.sh" ] && source $KBASH/colors.sh

# Load preferences
[ -f "$KBASH/defaults.sh" ] && source $KBASH/defaults.sh
[ -f "$KBASH/custom.sh" ] && source $KBASH/custom.sh

# Fancy manpages
export LESS_TERMCAP_md=$'\E[0;36m'
export LESS_TERMCAP_so=$'\E[1;33m'
export LESS_TERMCAP_us=$'\E[0;33m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_ue=$'\E[0m'

# Set prompt
if [ `id -u` -eq 0 ]; then
	export PS1="$GRAY\t [$WHITE[$HOSTCOLOR \h $WHITE]$GRAY] $ROOTCOLOR\u$GRAY:$ROOTDIRCOLOR\w$WHITE # $NOCOLOR"
else
	export PS1="$GRAY\t [$WHITE[$HOSTCOLOR \h $WHITE]$GRAY] $NAMECOLOR\u$GRAY:$DIRCOLOR\w$GRAY $ $NOCOLOR"
fi

# Xterm title
case "$TERM" in
xterm*|rxvt*)
	PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
	;;
*)
	;;
esac

# load keychain
[ -x /usr/bin/keychain ] && [ `id -u` -ne 0 ] && eval `keychain -q -Q --eval id_rsa`

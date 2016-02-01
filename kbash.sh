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

# use vi bindings
set -o vi

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups

# check the window size after each command and, if necessary, update the values of LINES and COLUMNS.
shopt -s checkwinsize

# append to .bash_history instead of overwrite.
shopt -s histappend

# write to .bash_history immediately.
export PROMPT_COMMAND="history -a;$PROMPT_COMMAND"

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# KBASH: where are the source file tree?
scriptpath=`readlink -m $BASH_ARGV`
export KBASH=`dirname $scriptpath`

# Environment variables
export LC_ALL="en_US.UTF-8"
export PATH=$PATH:~/bin:$KBASH/bin
export VISUAL="TERM=xterm-256color /usr/bin/vim"
export EDITOR=$VISUAL
export VIMINIT="set rtp+=$KBASH/vim | source $KBASH/rc/.vimrc"

# «old and crusty»
unset TERMCAP

# Standard aliases
alias c='clear'
alias ls='ls --color'
alias dir='ls --color --format=long'
alias dri='ls --color --format=long'
alias dirs='ls --color --format=long -d */'
alias dirf='ls --color --format=long --classify | egrep -v "/$"'
alias scpresume='rsync --partial --progress --rsh=ssh'
alias gitall='git commit -a -m'
alias ipcalc='ipcalc --nocolor'
alias tax='tmux detach >/dev/null 2>&1; tmux attach || tmux'
alias mkp='makepasswd --chars=30'
alias g='ack-grep'
alias vim="$VISUAL"

# Fast directory traversal
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# Apt
alias ac='sudo apt-cache'
alias ai='sudo apt-get install'

# Colorized grepping
alias grep='grep --color'
alias egrep='egrep --color'
alias less='less -R'

# Include a colors file
[ -f "$KBASH/colors.sh" ] && source $KBASH/colors.sh

# Prompt colors
export ROOTNAMECOLOR=$LTRED
export ROOTHOSTCOLOR=$LTRED
export ROOTDIRCOLOR=$RED
export USERNAMECOLOR=$GREEN
export USERHOSTCOLOR=$CYAN
export USERDIRCOLOR=$BROWN

# Site-local configuration
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
	PROMPT_COMMAND='PS1="$ROOTNAMECOLOR\u$NOCOLOR@$ROOTHOSTCOLOR\h $ROOTDIRCOLOR\w \`if [[ \$? = "0" ]]; then echo "\\[\\033[1\\\;37m\\]"; else echo "\\[\\033[1\\\;31m\\]"; fi\`# $NOCOLOR"'
else
	PROMPT_COMMAND='PS1="$USERNAMECOLOR\u$NOCOLOR@$USERHOSTCOLOR\h $USERDIRCOLOR\w \`if [[ \$? = "0" ]]; then echo "\\[\\033[0\\\;30m\\]"; else echo "\\[\\033[1\\\;31m\\]"; fi\`\$ $NOCOLOR"'
fi

# load keychain
[ -x /usr/bin/keychain ] && [ `id -u` -ne 0 ] && eval `keychain -q -Q --eval id_rsa`

return 0

# vi: se noet:
